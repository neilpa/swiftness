//
//  main.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/8/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

let path = "/Users/neilpa/code/emu/nes/test/nestest.nes"
//let path = "/Users/neilpa/code/emu/roms/Roms/VS/VS Super Mario Bros (VS).nes"
let cart = Cartridge(path: path)

// Dump the pattern tables

let tileBytes = 16

class PatternTile {
    let memory: Memory
    let offset: Address
    
    init(memory: Memory, offset: Address) {
        self.memory = memory
        self.offset = offset
    }
    
    subscript(x: Int, y: Int) -> Byte {
        let bit0 = (memory[offset + Address(x)] >> Byte(y)) & 1
        let bit1 = (memory[offset + Address(x) + 8] >> Byte(y)) & 1
        return (bit1 << 1) | bit0
    }
}

for tile in 0..<256 {
    let t = PatternTile(memory: cart.chrROM, offset: Address(tile * tileBytes))
    for row in 0...7 {
        for col in 0...7 {
            print(t[row, col])
        }
        println()
    }
    
    println()
}

//var cpu = CPU(memory: MemMap(cart: cart, ppu: PPU()))
//cpu.trace = true
//
//var count = 0
//while (true) {
//    // TODO Should return num cycles
//    print(String(format:"%05i", count++) + "  ")
//    cpu.step()
//}
