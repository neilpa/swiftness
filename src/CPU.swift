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
    return value
}

@prefix @assignment func --- (inout address: UInt16) -> UInt16 {
    address -= 2
    return address
}

@postfix @assignment func --- (inout address: UInt16) -> UInt16 {
    let value = address
    address -= 2
    return value
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
    var pc: UInt16 = 0 // TODO resetVector

    // Memory
    var mem: Memory

    init(memory: Memory) {
        mem = memory
    }
    
    // Register helpers

    // Get a bit from the status register
    func getFlag(mask: UInt8) -> Bool {
        return flags & mask != 0
    }

    // Set or clear a bit in the status register
    func setFlag(isSet: Bool, _ mask: UInt8) {
        if (isSet) {
            flags |= mask
        } else {
            flags &= ~mask
        }
    }

    // Update the negative and zero flags in the status register
    func setNZ(v: UInt8) {
        setFlag(v == 0, zeroMask)
        setFlag(v & 0x80 != 0, negativeMask)
    }

    // Stack helpers

    func push(v: UInt8) {
        // TODO What if the stack pointer wraps
        mem[stackOffset + UInt16(sp--)] = v
    }
    func pop() -> UInt8 {
        return mem[stackOffset + UInt16(++sp)]
    }
    
    // Instructions

    // Load operations
    func lda(mode: AddressingMode) {
        a = load(mode)
    }

    // Store operations
    func sta(mode: AddressingMode) {
        store(mode, a)
    }

    func load (mode: AddressingMode) -> UInt8 {
        switch mode {
            
        case .Immediate: return fetch()
            
            //        case .Accumulator:
            //        case .ZeroPage:
            //        case .ZeroPageX:
            //        case .ZeroPageY:
            //        case .Relative:
            //        case .Absolute:
            //        case .AbsoluteX:
            //        case .AbsoluteY:
            //        case .Indirect:
            //        case .IndexedIndirectX:
            //        case .IndirectIndexedY:
            
        case .Implicit: fallthrough // TODO What's the right answer here
        default:
            assert(false)
            return 0
        }
    }
    
    func store (mode: AddressingMode, _ value: UInt8) {

        switch mode {
            
        case .Absolute:
            let addr: UInt16 = cpu.fetch()
            cpu.mem[addr] = value
            
            //        case .Accumulator:
            //        case .ZeroPage:
            //        case .ZeroPageX:
            //        case .ZeroPageY:
            //        case .Relative:
            //        case .AbsoluteX:
            //        case .AbsoluteY:
            //        case .Indirect:
            //        case .IndexedIndirectX:
            //        case .IndirectIndexedY:
            
        case .Immediate: fallthrough
        case .Implicit:  fallthrough // TODO What's the right answer here
        default:
            assert(false)
        }
    }

    // Fetch opcode or arguments at PC and increment
    func fetch() -> UInt8 {
        return mem[pc++]
    }
    func fetch() -> UInt16 {
        return mem[pc+++]
    }
    
    // Decode the operation
    func decode(opcode: UInt8) -> (Instruction, AddressingMode) {
        return instructionSet[Int(opcode)]
    }

    // The fetch-decode-execute loop
    func run() {
        while (true) {
            let code: UInt8 = fetch()
            let (instruction, mode) = decode(code)

            switch instruction {

            case .LDA: lda(mode)
            case .STA: sta(mode)

            // Do nothing
            case .NOP: break

            // TODO For now use BRK to halt execution
            case .BRK: return

            // Unrecognized opcode
            default: assert(false)
                
            }
        }
    }

}
