//
//  Memory.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple interface to read/write memory
protocol Memory {
    subscript (address: Address) -> Byte { get set }
}

func readWord(addr: Address, mem: Memory) -> UInt16 {
    return UInt16(low: mem[addr], high: mem[addr + 1])
}

func writeWord(addr: Address, val: UInt16, var mem: Memory) {
    mem[addr] = val.lowByte
    mem[addr + 1] = val.highByte
}
