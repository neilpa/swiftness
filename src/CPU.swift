//
//  CPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

let negativeMask:   Byte = 1 << 7
let overflowMask:   Byte = 1 << 6
let brkMask:        Byte = 1 << 4
let decimalMask:    Byte = 1 << 3
let irqMask:        Byte = 1 << 2
let zeroMask:       Byte = 1 << 1
let carryMask:      Byte = 1 << 0

let stackOffset: Address = 0x0100
let resetVector: Address = 0xfffe

class CPU {

    // General purpose registers
    var a: Register = 0 // accumulator
    var x: Register = 0 // x indexer
    var y: Register = 0 // y indexer

    // Stack pointer starts at the top and grows down
    // TODO Double check stack behavior
    var sp: Register = 0xff

    // Processor status flags register
    var flags: Register = 0

    // Program counter register
    var pc: Address = 0 // TODO resetVector

    // Memory
    var mem: Memory

    init(memory: Memory) {
        mem = memory
    }
    
    // Register helpers

    // Get a bit from the status register
    func getFlag(mask: Byte) -> Bool {
        return flags & mask != 0
    }

    // Set or clear a bit in the status register
    func setFlag(isSet: Bool, _ mask: Byte) {
        if (isSet) {
            flags |= mask
        } else {
            flags &= ~mask
        }
    }

    // Update the negative and zero flags in the status register
    func setNZ(v: Byte) {
        setFlag(v == 0, zeroMask)
        setFlag(v & 0x80 != 0, negativeMask)
    }

    // Stack helpers

    func push(v: Byte) {
        // TODO What if the stack pointer wraps
        mem[stackOffset + Address(sp--)] = v
    }
    func pop() -> Byte {
        return mem[stackOffset + Address(++sp)]
    }
    
    // Instructions

    // Load operations
    func lda(mode: AddressingMode) {
        a = mode.load(self)
    }

    // Store operations
    func sta(mode: AddressingMode) {
        mode.store(self, a)
    }

    // Fetch opcode or arguments at PC and increment
    func fetch() -> Byte {
        return mem[pc++]
    }
    func fetch() -> UInt16 {
        return mem[pc+++]
    }
    
    // Decode the operation
    func decode(opcode: Byte) -> (Instruction, AddressingMode) {
        return instructionSet[Int(opcode)]
    }

    // The fetch-decode-execute loop
    func run() {
        while (true) {
            let code: Byte = fetch()
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
