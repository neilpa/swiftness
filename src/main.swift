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

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    a9 01     LDA #$ff
// $0602    8d 00 02  STA $0200
var mem = RAM(prog: [ 0xa9, 0xff, 0x8d, 0x00, 0x02 ])
cpu = CPU(memory: mem)
run(2)

println(mem.data[0..<10])
println(mem.data[0x200])
println(cpu.pc)
println(cpu.a)

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    69 ff     ADC #$ff
// $0602    69 01     ADC #$01
cpu = CPU(memory: RAM(prog: [ 0x69, 0xff, 0x69, 0x01]))
run(2)

println(cpu.a)
println(cpu.getFlag(carryMask))
println(cpu.getFlag(overflowMask))

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    69 7f     ADC #$7f
// $0602    69 05     ADC #$05
cpu = CPU(memory: RAM(prog: [ 0x69, 0x7f, 0x69, 0x05]))
run(2)

println(cpu.a)
println(cpu.getFlag(carryMask))
println(cpu.getFlag(overflowMask))

// Address  Hexdump   Dissassembly
// -------------------------------
// $0600    a2 fe     LDX #$fe
// $0602    e0 ff     CPX #$ff
cpu = CPU(memory: RAM(prog: [ 0xa2, 0xfe, 0xe0, 0xff]))
run(2)

println(cpu.x)
println(cpu.getFlag(carryMask))
println(cpu.getFlag(zeroMask))
println(cpu.getFlag(negativeMask))
