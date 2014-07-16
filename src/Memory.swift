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

// Mirror a block of memory every `size` bytes

class MemMirror : Memory {
    var memory: Memory
    let size: Address
    
    init (var memory: Memory, size: Address) {
        self.memory = memory
        self.size = size
    }

    subscript (addr: Address) -> Byte {
        get {
            return memory[addr % size]
        }
        set {
            memory[addr % size] = newValue
        }
    }
}

// Offset a block of memory

class MemOffset : Memory {
    var memory: Memory
    let offset: Address
    
    init(var memory: Memory, offset: Address) {
        self.memory = memory
        self.offset = offset
    }
    
    subscript (addr: Address) -> Byte {
        // TODO What about wrap/overflow
        get {
            return memory[addr - offset]
        }
        set {
            memory[addr - offset] = newValue
        }
    }
}
