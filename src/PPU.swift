//
//  PPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// The NES Picture Processing Unit

//
// From http://nesdev.icequake.net/NES%20emulation%20discussion.txt
//
// CPUCC to X/Y coordinate equations
// ---------------------------------
// The PPU renders 3 pixels in one CPU clock. Therefore, by multiplying the CPU
// CC figure by 3, we get the total amount of pixels that have been rendered
// (including non-displayed ones) since the VINT.
//
// 341 pixels are rendered per scanline (although only 256 are displayed).
// Therefore, by dividing PPUCC by this, we get the # of completely rendered
// scanlines since the VINT.
//
// 21 blank scanlines are rendered before the first visible one is displayed.
// So, to get a scanline offset into the actual on-screen image, we simply
// subtract the amount of non-displayed scanlines. Note that if this yeilds a
// negative number, the PPU is still in the V-blank period.
//
// PPUCC = CPUCC * 3
// Scanline = PPUCC div 341 - 21
// PixelOfs = (PPUCC+16) mod 341
// CPUcollisionCC = ((Y+21)*341+X)/3
//
// Note that if the PixelOfs equation yeilds a number higher than 255, the PPU
// is in the H-blank period. Also, fetched pattern table bitmaps have to travel
// through internal shift registers before they appear on the video out of the
// PPU, and that's why you see a +16 there; this is the delay.
//

// TODO Need to wrap my head around CPUcollissionCC

let vblankScanlines = 21

let screenWidth = 256
let screenHeight = 240

// TODO Look to cleanup some of this code

class PPU {

    // TODO Consider representing these in a more effecient manner
    // PPU Registers

    struct Ctrl {
        var value: Register = 0

        var nameTableAddr: Address {
            return 0x2000 + Address(value % 4) * 0x0400
        }
        var writeIncrement: Address {
            return value & (1 << 2) != 0 ? 32 : 1
        }
        var spritePatternTable: Address {
            return value & (1 << 3) != 0 ? 0x1000 : 0x0000
        }
        var backgroundPatternTable: Address {
            return value & (1 << 4) != 0 ? 0x1000 : 0x0000
        }
        var doubleSpriteSize : Bool {
            return value & (1 << 5) != 0
        }
        var vblankNMI: Bool {
            return value & (1 << 7) != 0
        }
    }
    var ctrl = Ctrl()

    struct Mask {
        var value: Register = 0

        var monochrome: Bool {
            return value & (1 << 0) == 0
        }
        var clipScreen: Bool {
            return value & (1 << 1) == 0
        }
        var clipSprites: Bool {
            return value & (1 << 2) == 0
        }
        var showScreen: Bool {
            return value & (1 << 3) != 0
        }
        var showSprites: Bool {
            return value & (1 << 4) != 0
        }
        var backgroundColor: Int {
            return Int(value >> 5)
        }
    }
    var mask = Mask()

    // Note: All bits are cleared on line 0.
    //       Bit 7 is cleared on read.
    //       The PPU Toggle Bit is also cleared
    struct Status {
        var value: Register = 0x80

        var spriteOverflowFlag: Bool {
            return value & (1 << 5) != 0
        }
        var spriteHitFlag: Bool {
            return value & (1 << 6) != 0
        }
        var vblankFlag: Bool {
            return value & (1 << 7) != 0
        }
    }
    var status = Status()

    // $2003 | W   | Sprite Memory Address
    //       |     | Used to set the address of the 256-byte Sprite Memory to be 
    //       |     | accessed via $2004. This address will increment by 1 after
    //       |     | each access to $2004. Sprite Memory contains coordinates,
    //       |     | colors, and other sprite attributes.
    // $2004 | RW  | Sprite Memory Data
    //       |     | Used to read/write the Sprite Memory. The address is set via
    //       |     | $2003 and increments by 1 after each access. Sprite Memory 
    //       |     | contains coordinates, colors, and other sprite attributes
    //       |     | sprites.
    var spriteIndex: Register = 0
    var spriteMemory = RAM(size: 256)
    func readSprite() -> Byte {
        return spriteMemory[Address(spriteIndex++)]
    }
    func writeSprite(val: Byte) {
        spriteMemory[Address(spriteIndex++)] = val
    }
    
    // TODO Sane explination here
    // http://wiki.nesdev.com/w/index.php/PPU_scrolling
    // var vramAddress: Address = 0
    // var vramLatch: Address = 0
    // var vramFlipFlop: Bool = false
    
    // $2005 | W   | Screen Scroll Offsets
    //       |     | There are two scroll registers, vertical and horizontal, 
    //       |     | which are both written via this port. The first value written
    //       |     | will go into the Vertical Scroll Register (unless it is >239,
    //       |     | then it will be ignored). The second value will appear in the
    //       |     | Horizontal Scroll Register. Name Tables are assumed to be
    //       |     | arranged in the following way:
    //       |     |
    //       |     |           +-----------+-----------+
    //       |     |           | 2 ($2800) | 3 ($2C00) |
    //       |     |           +-----------+-----------+
    //       |     |           | 0 ($2000) | 1 ($2400) |
    //       |     |           +-----------+-----------+
    //       |     |
    //       |     | When scrolled, the picture may span over several Name Tables.
    //       |     | Remember that because of the mirroring there are only 2 real
    //       |     | Name Tables, not 4.
    var scroll: Register = 0

    var memAddr: Address = 0
    var lowByte: Bool = false
    func writeAddr(val: Byte) {
        if (lowByte) {
            memAddr = Address(low: val, high: memAddr.highByte)
        } else {
            memAddr = Address(low: memAddr.lowByte, high: val)
        }
        lowByte = !lowByte
    }
    func writeMem(val: Byte) {
        if (0x3F00 <= memAddr && memAddr <= 0x3FFF) {
            palette[memAddr] = val
        } else {
            nameTables[memAddr] = val
//            println("nametable[\(memAddr.hex)] = \(val) {\(nameTables[memAddr])}")
        }
        memAddr += ctrl.writeIncrement
    }

    // $4014 | W   | DMA Access to the Sprite Memory
    //       |     | Writing a value N into this port causes an area of CPU memory
    //       |     | at address $100*N to be transferred into the Sprite Memory. It
    //       |     | does this 256 times thus being 512 CPU cycles long. Most if not
    //       |     | all games write $00 to $2003 before writing to the DMA. The DMA
    //       |     | purpose is to update the PPU's sprram quickly during thet
    //       |     | precious vblank time.
    // N.B. During this time the CPU is effectively stalled since the data bus is in
    // use to do the DMA, preventing the CPU from fetching instructions
    // TODO

    // PPU Memory Map
    // TODO These need to mirror (and check my offsets/sizes)
    var nameTables: Memory = MemOffset(memory: RAM(size: 0x1000), offset: 0x2000)
    var palette: Memory = MemOffset(memory: RAM(size: 0x0100), offset: 0x3F00)

    // TODO
    // Remaining 64 bytes after nametable is an attribute table

    // Nametable is 960 bytes of RAM for the background
    // Each byte maps to 8x8 pixel tile on screen (32 rows by 30 columns)
    // That byte is an index into cartridge ROM's pattern table
    
    //  Mapping of x,y pixel coordinates on screen to the
    //  name table index (ignoring current scroll offset)
    //
    //         000...007 = 008       247 = 248...255
    //       +---------- = ---       --- = ----------+
    //   000 | 000   000 = 001       030 = 031   031 | 000
    //   ... |           =               =           | ...
    //   007 | 000   000 = 001       030 = 031   031 | 007
    //   = = = = = = = = % = =       = = % = = = = = = = =
    //   008 | 032   032 = 033       062 = 063   063 | 008
    //
    //
    //   231 | 896   896 = 897       926 = 927   927 | 231
    //   = = = = = = = = % = =       = = % = = = = = = = =
    //   232 | 928   928 = 929       958 = 959   959 | 232
    //   ... |           =               =           | ...
    //   239 | 928   928 = 929       958 = 959   959 | 239
    //       +---------- = ---       --- = ----------+
    //         000...007 = 008       247 = 248...255
    //
    let screenWidth = 256
    let screenHeight = 240
    
    // A pattern table consists of 256 8x8 pixel tiles
    // Each 8x8 pattern tile is 16 bytes, e.g. 2 bits per pixel
    // The lower 8 bytes are bit 0 of each pixel
    // The higher 8 bytes are bit 1 of each pixel
    let tileWidth = 8
    let tileHeight = 8
    let bytesPerTile = 16

    let nameTableColumns = 32 // screenWidth / tileWidth
    let nameTableRows = 30 // screenHeight / tileHeight
    
    // TODO Kill this, and start counting cycles
    func raster(cart: Cartridge) {
        for scanline in 0..<screenHeight {
            // Base nametable index for this row following above layout
            let nameTableBase = (scanline / tileHeight) * nameTableColumns

            for x in 0..<screenWidth {
                let nameTableIndex = nameTableBase + (x / tileWidth)
                let nameTableAddr = ctrl.nameTableAddr + Address(nameTableIndex)
                let tileIndex = nameTables[nameTableAddr]
                let tileBase = Int(tileIndex) * bytesPerTile + scanline % tileHeight
                let tileAddr = Address(tileBase) + ctrl.backgroundPatternTable

                // TODO Pick the right ROM
                let plane0 = cart.chrROM[tileAddr]
                let plane1 = cart.chrROM[tileAddr + Address(tileHeight)]
                let shift = 7 - Byte(x % tileWidth)
                let bit0 = (plane0 >> shift) & 1
                let bit1 = (plane1 >> shift) & 1
                let color = bit1 << 1 | bit0
                
                // TODO Attribute table
                // TODO Color from palette

                screen[scanline*screenWidth + x].R = color
                screen[scanline*screenWidth + x].G = color
                screen[scanline*screenWidth + x].B = color
            }
        }
    }

    // PPU Bookkeeping
    var screen = [ColorRGB](count:256*240, repeatedValue: ColorRGB(0, 0, 0))
    //let scanline = 0
    //let cycle = 0
    
    func step() {
    }
}
