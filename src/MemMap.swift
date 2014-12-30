//
//  MemMap.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// NES Memory Map

// +--------------+---------------+---------------+-----------------------+
// |    Address   |   End         |    Size       | Description           |
// +--------------+---------------+---------------+-----------------------+
// |    $0000     |   $1FFF       |    $0800      | Ram                   |
// |    $2000     |   $3FFF       |    $0008      | PPU Registers         |
// |    $4000     |   $4017       |    $0018      | APU & Input Registers |
// |    $4018     |   $5FFF       |    $1FE8      | Written to cart *1    |
// |    $6000     |   $7FFF       |    $2000      | s/w ram on cart *2    |
// |    $8000     |   $FFFF       |    $8000      | Program Rom *2        |
// +--------------+---------------+---------------+-----------------------+
//  *1: Carts may use this offset range & written values for a number of things
//  *2: May be switch able depending on cart Along with *1

// TODO Look to cleanup some of this code

class MemMap : Memory {
    var ram: Memory
    let rom: Memory
    var ppu: PPU
    
    init(cart: Cartridge, ppu: PPU) {
        // TODO Internal RAM is mirrored 4 times
        //self.ram = MemMirror(memory: RAM(size: 0x800), size: 0x8000)
        self.ram = RAM(size: 0x8000)
        
        // Program ROM is loaded at 0x8000
        self.rom = MemOffset(memory: cart.prgROM, offset: 0x8000)

        // TODO PPU registers are mapped to 0x2000
        self.ppu = ppu
    }

    subscript (addr: Address) -> Byte {
        // TODO Figure out why I can't get pattern matching to work
        get {
            if (0x2000 <= addr && addr <= 0x3fff) {
                // TODO Some of this is broken
                switch addr % 8 {
                case 0: return ppu.ctrl.value
                case 1: return ppu.mask.value
                case 2: return ppu.status.value // TODO update on read
                case 3: return ppu.spriteIndex
                case 4: return 0 // TODO
                case 5: return ppu.scroll
                case 6: return 0 // TODO
                case 7: return 0 // TODO
                default: return 0 // TODO
                }
            } else if (0x4014 == addr) {
                // TODO Sprite DMA needs to be in the CPU
                return 0
            } else if (0x0000 <= addr && addr <= 0x7fff) {
                return ram[addr]
            } else if (0x8000 <= addr && addr <= 0xffff) {
                return rom[addr]
            } else {
                assert(false, "Invalid address")
                return 0
            }
        }
        set {
            if (0x2000 <= addr && addr <= 0x3fff) {
                switch addr % 8 {
                case 0:
                    println("PPU Ctrl \(newValue.hex)")
                    ppu.ctrl.value = newValue // TODO
                case 1:
                    println("PPU Mask \(newValue.hex)")
                    ppu.mask.value = newValue // TODO
                case 2:
                    assert(false, "Can't right status")
                case 3:
                    ppu.spriteIndex = newValue
                case 4:
                    ppu.writeSprite(newValue)
                case 5:
                    ppu.scroll = newValue // TODO is this right?
                case 6:
                    ppu.writeAddr(newValue)
                case 7:
                    ppu.writeMem(newValue)
                default:
                    break
                }
            } else if (0x4014 == addr) {
                // TODO Sprite DMA
                // Is this the right spot?
                println("DMA Write \(newValue.hex)")
            } else if (0x0000 <= addr && addr <= 0x7fff) {
                ram[addr] = newValue
            } else if (0x8000 <= addr && addr <= 0xffff) {
                assert(false, "Can't write to ROM")
            } else {
                assert(false, "Invalid address")
            }
        }
    }
}
