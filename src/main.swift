//
//  main.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/8/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    a9 01     LDA #$ff
// $0602    8d 00 02  STA $0200
// $0605    00        BRK

let mem = RAM(prog: [ 0xa9, 0xff, 0x8d, 0x00, 0x02, 0x00 ])
println(mem.data[0..10])

let cpu = CPU(memory: mem)
cpu.run()

println(mem.data[0..10])

println(mem.data[0x200])

println(cpu.pc)
