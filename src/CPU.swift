//
//  CPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

class CPU {
    
    // General purpose registers
    var a: UInt8 = 0 // accumulator
    var x: UInt8 = 0 // x indexer
    var y: UInt8 = 0 // y indexer
    
    // Special purpose registers
    var sp: UInt8 = 0 // stack pointer
    var flags: UInt8 = 0 // processor status
    var pc: UInt16 = 0 // program counter
    
    // Simple 64KB of memory to start
    var mem: UInt8[] = UInt8[](count:2^16, repeatedValue:0)
    
    // The fetch-decode-execute loop
    func run() -> () {
        
    }

}