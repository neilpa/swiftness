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

class MemMap : Memory {
    var ram: Memory
    let rom: Memory
    var ppu: PPU
    
    let blackhole = MemNil()

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
        get {
            return map(addr)[addr]
        }
        set {
            var memory = map(addr)
            memory[addr] = newValue
        }
    }

    // Resolve to the underlying memory block
    func map(addr: Address) -> Memory {
        if (0x0000 <= addr && addr <= 0x7fff) {
            return ram
        } else if (0x8000 <= addr && addr <= 0xffff) {
            return rom
        } else {
            assert(false, "Invalid address")
        }
        
        // TODO Not sure why these pattern matches don't work
//        switch addr {
//            case 0x0000...0x7fff: return ram
//            case 0x8000...0xffff: return rom
//            default: assert(false, "Not implemented")
//        }
        
        return blackhole
    }
}

// Memory black hole for invalid cases

class MemNil : Memory {
    subscript (addr: Address) -> Byte {
        // TODO Trace invalid accesses here
        get { return 0 }
        set { }
    }
}
