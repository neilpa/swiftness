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
let cart = NSData(contentsOfFile: path)

var size = 16 * 1024
var rom = [Byte](count: size, repeatedValue: 0)
cart.getBytes(&rom, range: NSMakeRange(16, size))

cpu = CPU(memory: RAM(prog: rom, offset: 0xc000))

// HACK expected starting context
cpu.pc = 0xc000
cpu.sp = 0xfd
cpu.setFlag(true, irqMask)

run(1000)
