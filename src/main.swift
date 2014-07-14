//
//  main.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/8/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

var cpu: CPU = CPU(memory: RAM(prog: []))
func run(var count: Int) {
    while (--count > 0) {
        cpu.step()
    }
}

let path = "/Users/neilpa/code/emu/nes/test/nestest.nes"
let cart = Cartridge(path: path)

cpu = CPU(memory: RAM(prog: cart.prgROM, offset: 0xc000))

// HACK expected starting context
cpu.pc = 0xc000
cpu.sp = 0xfd
cpu.setFlag(true, irqMask)

run(9000)
