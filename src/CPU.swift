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

// Instructions

extension CPU {

    // Load operations
    func lda(mode: AddressingMode) {
        a = mode.load(self)
        setNZ(a)
    }
    func ldx(mode: AddressingMode) {
        x = mode.load(self)
        setNZ(x)
    }
    func ldy(mode: AddressingMode) {
        y = mode.load(self)
        setNZ(y)
    }

    // Store operations
    func sta(mode: AddressingMode) {
        mode.store(self, a)
    }
    func stx(mode: AddressingMode) {
        mode.store(self, x)
    }
    func sty(mode: AddressingMode) {
        mode.store(self, y)
    }

    // Register transfer operations
    func tax(mode: AddressingMode) {
        assert(mode == AddressingMode.Implicit)
        x = a
        setNZ(x)
    }
    func tay(mode: AddressingMode) {
        assert(mode == .Implicit)
        y = a
        setNZ(y)
    }
    func txa(mode: AddressingMode) {
        assert(mode == .Implicit)
        a = x
        setNZ(a)
    }
    func tya(mode: AddressingMode) {
        assert(mode == .Implicit)
        a = y
        setNZ(a)
    }
    func tsx(mode: AddressingMode) {
        assert(mode == .Implicit)
        x = sp
        setNZ(x)
    }
    func txs(mode: AddressingMode) {
        assert(mode == .Implicit)
        sp = x
    }

    // Stack operations
    func pha(mode: AddressingMode) {
        assert(mode == .Implicit)
        push(a)
    }
    func php(mode: AddressingMode) {
        assert(mode == .Implicit)
        push(flags)
    }
    func pla(mode: AddressingMode) {
        assert(mode == .Implicit)
        a = pop()
    }
    func plp(mode: AddressingMode) {
        assert(mode == .Implicit)
        flags = pop()
    }

    // Logical operations
    func and(mode: AddressingMode) {
        a &= mode.load(self)
        setNZ(a)
    }
    func eor(mode: AddressingMode) {
        a ^= mode.load(self)
        setNZ(a)
    }
    func ora(mode: AddressingMode) {
        a |= mode.load(self)
        setNZ(a)
    }
    func bit(mode: AddressingMode) {
        assert(false, "Not implemented")
        let v = mode.load(self)
        setFlag(v & a == 0, zeroMask)
        setFlag(v & 0x80 != 0, negativeMask)
        setFlag(v & 0x40 != 0, overflowMask)
    }

    // Arithmetic operations
    func adc(mode: AddressingMode) {
        let val = mode.load(self)

        // Let Swift figure out carry and overflow
        var (res, carry) = Byte.addWithOverflow(a, val)
        var (signed, overflow) = Int8.addWithOverflow(a.asSigned(), val.asSigned())

        // Check if that final bit pushes us over the top
        if (getFlag(carryMask)) {
            if !carry {
                (res, carry) = Byte.addWithOverflow(res, 1)
            } else {
                // Already, one more bit isn't going to change that
                (res, _) = Byte.addWithOverflow(res, 1)
            }
            
            if !overflow {
                // Still need to check for signed overflow on the last bit
                (_, overflow) = Int8.addWithOverflow(signed, 1)
            }
        }
        
        setFlag(carry, carryMask)
        setFlag(overflow, overflowMask)
        setNZ(res)
        a = res
    }
    func sbc(mode: AddressingMode) {
        let val = mode.load(self)
        
        // Let Swift figure out carry and overflow
        var (res, carry) = Byte.subtractWithOverflow(a, val)
        var (signed, overflow) = Int8.subtractWithOverflow(a.asSigned(), val.asSigned())
        
        // Check if that final bit pushes us over the top
        if (getFlag(carryMask)) {
            if !carry {
                (res, carry) = Byte.subtractWithOverflow(res, 1)
            } else {
                // Already, one more bit isn't going to change that
                (res, _) = Byte.subtractWithOverflow(res, 1)
            }
            
            if !overflow {
                // Still need to check for signed overflow on the last bit
                (_, overflow) = Int8.subtractWithOverflow(signed, 1)
            }
        }
        
        setFlag(carry, carryMask)
        setFlag(overflow, overflowMask)
        setNZ(res)
        a = res
    }
    
    // Comparison operations
    func cmp(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func cpx(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func cpy(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Increment operations
    func inc(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func inx(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func iny(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Decrement operations
    func dec(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func dex(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func dey(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Shift operations
    func asl(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func lsr(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func rol(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func ror(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Jump operations
    func jmp(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    
    // Call operations
    func jsr(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func rts(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Branch operations
    func bcc(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bcs(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func beq(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bmi(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bne(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bpl(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bvc(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func bvs(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // Status flag operations
    func clc(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func cld(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func cli(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func clv(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func sec(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func sed(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func sei(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

    // System operations
    func brk(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func nop(mode: AddressingMode) {
        assert(false, "Not implemented")
    }
    func rti(mode: AddressingMode) {
        assert(false, "Not implemented")
    }

}