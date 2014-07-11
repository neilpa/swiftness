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

var mem = RAM(prog: [ 0xa9, 0xff, 0x8d, 0x00, 0x02, 0x00 ])
println(mem.data[0..<10])

var cpu = CPU(memory: mem)
cpu.run()

println(mem.data[0..<10])
println(mem.data[0x200])
println(cpu.pc)


// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    69 ff     ADC #$ff
// $0602    69 01     ADC #$01

mem = RAM(prog: [ 0x69, 0xff, 0x69, 0x01])
cpu = CPU(memory: mem)
cpu.run()

println(cpu.a)
println(cpu.getFlag(carryMask))
println(cpu.getFlag(overflowMask))

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    69 7f     ADC #$7f
// $0602    69 05     ADC #$05

mem = RAM(prog: [ 0x69, 0x7f, 0x69, 0x05])
cpu = CPU(memory: mem)
cpu.run()

println(cpu.a)
println(cpu.getFlag(carryMask))
println(cpu.getFlag(overflowMask))

