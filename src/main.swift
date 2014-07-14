//
//  main.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/8/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

//let path = "/Users/neilpa/code/emu/nes/test/nestest.nes"
let path = "/Users/neilpa/code/emu/roms/Roms/VS/VS Super Mario Bros (VS).nes"
let cart = Cartridge(path: path)

var cpu = CPU(memory: MemMap(cart: cart, ppu: PPU()))
//cpu.trace = true

while (true) {
    // TODO Should return num cycles
    cpu.step()
}
