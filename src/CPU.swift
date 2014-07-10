//
//  CPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Convenience operators for incrementing/decrememting registers by 2. I expect
// these to be quite handy because compound assignment (x+=2) is a statement rather
// than an expression returning the assigned value.

operator prefix +++ {}
operator postfix +++ {}
operator prefix --- {}
operator postfix --- {}

@prefix @assignment func +++ (inout address: UInt16) -> UInt16 {
    address += 2
    return address
}

@postfix @assignment func +++ (inout address: UInt16) -> UInt16 {
    let value = address
    address += 2
    return address
}

@prefix @assignment func --- (inout address: UInt16) -> UInt16 {
    address -= 2
    return address
}

@postfix @assignment func --- (inout address: UInt16) -> UInt16 {
    let value = address
    address -= 2
    return address
}

let negativeMask:   UInt8 = 1 << 7
let overflowMask:   UInt8 = 1 << 6
let brkMask:        UInt8 = 1 << 4
let decimalMask:    UInt8 = 1 << 3
let irqMask:        UInt8 = 1 << 2
let zeroMask:       UInt8 = 1 << 1
let carryMask:      UInt8 = 1 << 0

let stackOffset: UInt16 = 0x0100
let resetVector: UInt16 = 0xfffe

class CPU {
    
    // General purpose registers
    var a: UInt8 = 0 // accumulator
    var x: UInt8 = 0 // x indexer
    var y: UInt8 = 0 // y indexer

    // Stack pointer starts at the top and grows down
    // TODO Double check stack behavior
    var sp: UInt8 = 0xff

    // Processor status flags register
    var flags: UInt8 = 0

    // Program counter register
    var pc: UInt16 = resetVector

    // Memory
    var mem: Memory

    init(memory: Memory) {
        mem = memory
    }
    
    // Register helpers
    
    // Set or clear a bit in the status register
    func updateFlag (isSet: Bool, _ mask: UInt8) {
        if (isSet) {
            flags |= mask
        } else {
            flags &= ~mask
        }
    }

    // Update the negative and zero flags in the status register
    func updateNZ (v: UInt8) {
        updateFlag(v == 0, zeroMask)
        updateFlag(v & 0x80 != 0, negativeMask)
    }

    // Stack helpers

    func push (v: UInt8) {
        // TODO What if the stack pointer wraps
        mem[stackOffset + UInt16(sp--)] = v
    }
    func pop () -> UInt8 {
        return mem[stackOffset + UInt16(++sp)]
    }

    // The fetch-decode-execute loop
    func run() {
        
    }

}
