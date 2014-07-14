//
//  PPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// The NES Picture Processing Unit

class PPU {

    // $2000 | RW  | PPU Control Register 1
    //       | 0-1 | Name Table Address:
    //       |     |
    //       |     |           +-----------+-----------+
    //       |     |           | 2 ($2800) | 3 ($2C00) |
    //       |     |           +-----------+-----------+
    //       |     |           | 0 ($2000) | 1 ($2400) |
    //       |     |           +-----------+-----------+
    //       |     |
    //       |     | Remember that because of the mirroring there are only 2  
    //       |     | real Name Tables, not 4. Also, PPU will automatically
    //       |     | switch to another Name Table when running off the current
    //       |     | Name Table during scroll (see picture above).
    //       |   2 | Vertical Write, 1 = PPU memory address increments by 32:
    //       |     |
    //       |     |    Name Table, VW=0          Name Table, VW=1
    //       |     |   +----------------+        +----------------+
    //       |     |   |----> write     |        | | write        |
    //       |     |   |                |        | V              |
    //       |     |
    //       |   3 | Sprite Pattern Table Address, 1 = $1000, 0 = $0000.
    //       |   4 | Screen Pattern Table Address, 1 = $1000, 0 = $0000.
    //       |   5 | Sprite Size, 1 = 8x16, 0 = 8x8.
    //       |   6 | PPU Master/Slave Mode, not used in NES.
    //       |   7 | VBlank Enable, 1 = generate interrupts on VBlank.
    struct Ctrl {
        var value: Register = 0
        func __conversion() -> Register { return value }

        var nameTable: Address {
            return 0x2000 + Address(value % 4) * 0x0400
        }
        var writeIncrement: Address {
            return value & (1 << 2) != 0 ? 32 : 1
        }
        var spritePatternTable: Address {
            return value & (1 << 3) != 0 ? 0x1000 : 0x0000
        }
        var screenPatternTable: Address {
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

    // $2001 | RW  | PPU Control Register 2
    //       |   0 | Monochrome colors
    //       |   1 | Image Mask, 0 = don't show left 8 columns of the screen.
    //       |   2 | Sprite Mask, 0 = don't show sprites in left 8 columns. 
    //       |   3 | Screen Enable, 1 = show picture, 0 = blank screen.
    //       |   4 | Sprites Enable, 1 = show sprites, 0 = hide sprites.
    //       | 5-7 | Background Color, 0 = black, 1 = blue, 2 = green, 4 = red.
    //       |     | Do not use any other numbers as you may damage PPU hardware.
    struct Mask {
        var value: Register = 0
        func __conversion() -> Register { return value }

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

    // $2002 | R   | PPU Status Register
    //       | 0-4 | Unknown (???)
    //       |   5 | Sprite Overflow
    //       |   6 | Hit Flag, 1 = Sprite refresh has hit sprite #0.
    //       |     | This flag resets to 0 when screen refresh starts
    //       |   7 | VBlank Flag, 1 = PPU is in VBlank state.
    //       |     | This flag resets to 0 when VBlank ends or CPU reads $2002
    //
    // Note: All bits are cleared on line 0.
    //       Bit 7 is cleared on read.
    //       The PPU Toggle Bit is also cleared
    struct Status {
        var value: Register = 0x80
        func __conversion() -> Register { return value }

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
    func writeSprite(val: Byte) {
        // TODO
    }
    
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
    
    // $2006 | W   | PPU Memory Address
    //       |     | Used to set the address of PPU Memory to be accessed via
    //       |     | $2007. The first write to this register will set 8 lower
    //       |     | address bits. The second write will set 6 upper bits. The
    //       |     | address will increment either by 1 or by 32 after each
    //       |     | access to $2007
    // $2007 | RW  | PPU Memory Data
    //       |     | Used to read/write the PPU Memory. The address is set via
    //       |     | $2006 and increments after each access, either by 1 or by 32
    var memAddress: Register = 0
    func writeMem(val: Byte) {
        // TODO
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
    let palette: [Byte] = [Byte](count: 0x20, repeatedValue: 0)
    let nameTables: [Byte] = [Byte](count: 0x1000, repeatedValue: 0)

    //---------------------------------------- $4000
    // Empty
    //---------------------------------------- $3F20
    // Sprite Palette
    //---------------------------------------- $3F10
    // Image Palette
    //---------------------------------------- $3F00
    // Empty
    //---------------------------------------- $3000
    // Attribute Table 3
    //---------------------------------------- $2FC0
    // Name Table 3 (32x30 tiles)
    //---------------------------------------- $2C00
    // Attribute Table 2
    //---------------------------------------- $2BC0
    // Name Table 2 (32x30 tiles)
    //---------------------------------------- $2800
    // Attribute Table 1
    //---------------------------------------- $27C0
    // Name Table 1 (32x30 tiles)
    //---------------------------------------- $2400
    // Attribute Table 0
    //---------------------------------------- $23C0
    // Name Table 0 (32x30 tiles)
    //---------------------------------------- $2000
    // Pattern Table 1 (256x2x8, may be VROM)
    //---------------------------------------- $1000
    // Pattern Table 0 (256x2x8, may be VROM)
    //---------------------------------------- $0000

}
