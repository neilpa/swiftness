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
//let path = "/Users/neilpa/code/emu/roms/Roms/VS/Soccer (VS).nes"
let cart = Cartridge(path: path)

// Dump the pattern tables

var ppu = PPU()
var cpu = CPU(memory: MemMap(cart: cart, ppu: ppu))
//cpu.trace = true

var count = 0
while (++count < 20000) {
    // TODO Should return num cycles
    //print(String(format:"%05i", count++) + "  ")
    cpu.step()
}

ppu.raster(cart)
