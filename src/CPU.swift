//
//  CPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

let negativeMask:   Byte = 1 << 7
let overflowMask:   Byte = 1 << 6
let brkMask:        Byte = 1 << 4
let decimalMask:    Byte = 1 << 3
let irqMask:        Byte = 1 << 2
let zeroMask:       Byte = 1 << 1
let carryMask:      Byte = 1 << 0

// Bit 5 is reserved and always set in the status flags
let defaultFlags: Byte = 1 << 5

let stackOffset: Address = 0x0100

let nmiVector:   Address = 0xfffa
let resetVector: Address = 0xfffc
let irqVector:   Address = 0xfffe

class CPU {

    // General purpose registers
    var a: Register = 0 // accumulator
    var x: Register = 0 // x indexer
    var y: Register = 0 // y indexer

    // Stack pointer starts at the top and grows down
    // TODO Double check stack behavior
    var sp: Register = 0xff

    // Processor status flags register
    var flags: Register = defaultFlags

    // Program counter register
    var pc: Address = 0 // TODO resetVector

    // Memory
    var mem: Memory
    
    // Disassembler for decoding/tracing instructions
    var disassembler: Disassembler

    init(memory: Memory) {
        mem = memory
        disassembler = Disassembler(mem: memory)
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
    func setNZ(val: Byte) -> Byte {
        setFlag(val == 0, zeroMask)
        setFlag(val & 0x80 != 0, negativeMask)
        return val
    }

    // Stack helpers

    func push(val: Byte) {
        // TODO What if the stack pointer wraps
        mem[stackOffset + Address(sp--)] = val
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
        let instr = disassembler.decode(opcode)
        return (instr.type, instr.mode)
    }

    // Step a single fetch-decode-execute cycle
    func step() {
        disassembler.trace(pc)
        println(String(format:"  A:%02X X:%02X Y:%02X P:%02X SP:%02X", a, x, y, flags, sp))

        let code: Byte = fetch()
        let (instruction, mode) = decode(code)
        
        switch instruction {
        case .ADC: adc(mode)
        case .AND: and(mode)
        case .ASL: asl(mode)
        case .BCC: bcc(mode)
        case .BCS: bcs(mode)
        case .BEQ: beq(mode)
        case .BIT: bit(mode)
        case .BMI: bmi(mode)
        case .BNE: bne(mode)
        case .BPL: bpl(mode)
        case .BRK: brk(mode)
        case .BVC: bvc(mode)
        case .BVS: bvs(mode)
        case .CLC: clc(mode)
        case .CLD: cld(mode)
        case .CLI: cli(mode)
        case .CLV: clv(mode)
        case .CMP: cmp(mode)
        case .CPX: cpx(mode)
        case .CPY: cpy(mode)
        case .DEC: dec(mode)
        case .DEX: dex(mode)
        case .DEY: dey(mode)
        case .EOR: eor(mode)
        case .INC: inc(mode)
        case .INX: inx(mode)
        case .INY: iny(mode)
        case .JMP: jmp(mode)
        case .JSR: jsr(mode)
        case .LDA: lda(mode)
        case .LDX: ldx(mode)
        case .LDY: ldy(mode)
        case .LSR: lsr(mode)
        case .NOP: nop(mode)
        case .ORA: ora(mode)
        case .PHA: pha(mode)
        case .PHP: php(mode)
        case .PLA: pla(mode)
        case .PLP: plp(mode)
        case .ROL: rol(mode)
        case .ROR: ror(mode)
        case .RTI: rti(mode)
        case .RTS: rts(mode)
        case .SBC: sbc(mode)
        case .SEC: sec(mode)
        case .SED: sed(mode)
        case .SEI: sei(mode)
        case .STA: sta(mode)
        case .STX: stx(mode)
        case .STY: sty(mode)
        case .TAX: tax(mode)
        case .TAY: tay(mode)
        case .TSX: tsx(mode)
        case .TXA: txa(mode)
        case .TXS: txs(mode)
        case .TYA: tya(mode)
        default: assert(false, "Unrecognized opcode")
        }
    }
}

// Instructions

extension CPU {

    // Load operations
    func lda(mode: AddressingMode) {
        a = setNZ(mode.resolve(self).load())
    }
    func ldx(mode: AddressingMode) {
        x = setNZ(mode.resolve(self).load())
    }
    func ldy(mode: AddressingMode) {
        y = setNZ(mode.resolve(self).load())
    }

    // Store operations
    func sta(mode: AddressingMode) {
        mode.resolve(self).store(a)
    }
    func stx(mode: AddressingMode) {
        mode.resolve(self).store(x)
    }
    func sty(mode: AddressingMode) {
        mode.resolve(self).store(y)
    }

    // Register transfer operations
    func tax(mode: AddressingMode) {
        x = setNZ(a)
    }
    func tay(mode: AddressingMode) {
        y = setNZ(a)
    }
    func txa(mode: AddressingMode) {
        a = setNZ(x)
    }
    func tya(mode: AddressingMode) {
        a = setNZ(y)
    }
    func tsx(mode: AddressingMode) {
        x = setNZ(sp)
    }
    func txs(mode: AddressingMode) {
        sp = x
    }

    // Stack operations
    func pha(mode: AddressingMode) {
        push(a)
    }
    func php(mode: AddressingMode) {
        push(flags)
    }
    func pla(mode: AddressingMode) {
        a = pop()
    }
    func plp(mode: AddressingMode) {
        flags = pop()
    }

    // Logical operations
    func and(mode: AddressingMode) {
        a = setNZ(a & mode.resolve(self).load())
    }
    func eor(mode: AddressingMode) {
        a = setNZ(a ^ mode.resolve(self).load())
    }
    func ora(mode: AddressingMode) {
        a = setNZ(a | mode.resolve(self).load())
    }
    func bit(mode: AddressingMode) {
        let val = mode.resolve(self).load()
        setFlag(val & a == 0, zeroMask)
        setFlag(val & 0x80 != 0, negativeMask)
        setFlag(val & 0x40 != 0, overflowMask)
    }

    // Arithmetic operations
    // TODO adc and sbc are identical except for addWithOverflow/subtractWithOverflow
    func adc(mode: AddressingMode) {
        let val = mode.resolve(self).load()

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
        a = setNZ(res)
    }
    func sbc(mode: AddressingMode) {
        let val = mode.resolve(self).load()

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
        a = setNZ(res)
    }

    // Comparison operations
    func compare(mode: AddressingMode, _ reg: Register) {
        let val = mode.resolve(self).load()
        setFlag(reg >= val, carryMask)

        let (res, _) = Byte.subtractWithOverflow(reg, val)
        setNZ(res)
    }
    func cmp(mode: AddressingMode) {
        compare(mode, a)
    }
    func cpx(mode: AddressingMode) {
        compare(mode, x)
    }
    func cpy(mode: AddressingMode) {
        compare(mode, y)
    }

    // Increment operations
    func inc(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let (res, _) = Byte.addWithOverflow(slot.load(), 1)
        slot.store(setNZ(res))
    }
    func inx(mode: AddressingMode) {
        let (res, _) = Byte.addWithOverflow(x, 1)
        x = setNZ(res)
    }
    func iny(mode: AddressingMode) {
        let (res, _) = Byte.addWithOverflow(y, 1)
        y = setNZ(res)
    }

    // Decrement operations
    func dec(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let (res, _) = Byte.subtractWithOverflow(slot.load(), 1)
        slot.store(setNZ(res))
    }
    func dex(mode: AddressingMode) {
        let (res, _) = Byte.subtractWithOverflow(x, 1)
        x = setNZ(res)
    }
    func dey(mode: AddressingMode) {
        let (res, _) = Byte.subtractWithOverflow(y, 1)
        y = setNZ(res)
    }

    // Shift operations
    func asl(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let val = slot.load()
        setFlag(val & 0x80 != 0, carryMask)
        slot.store(setNZ(val << 1))
    }
    func lsr(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let val = slot.load()
        setFlag(val & 0x01 != 0, carryMask)
        slot.store(setNZ(val >> 1))
    }
    func rol(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let val = slot.load()
        var res = val << 1
        if (getFlag(carryMask)) {
            res &= 0x01
        }
        setFlag(val & 0x80 != 0, carryMask)
        slot.store(setNZ(res))
    }
    func ror(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let val = slot.load()
        var res = val >> 1
        if (getFlag(carryMask)) {
            res &= 0x80
        }
        setFlag(val & 0x01 != 0, carryMask)
        slot.store(setNZ(res))
    }

    // Jump operations
    func jmp(mode: AddressingMode) {
        // TODO Replicate page boundary bug for indirect jumps
        let slot: MemorySlot = mode.resolve(self) as MemorySlot
        pc = slot.address
    }

    // Call operations
    func jsr(mode: AddressingMode) {
        let addr: Address = fetch()
        let ret = pc - 1
        push(ret.highByte)
        push(ret.lowByte)
        pc = addr
    }
    func rts(mode: AddressingMode) {
        pc = Address(low: pop(), high: pop()) + 1
    }

    // Branch operations
    func branch(jump: Bool) {
        let operand: Int8 = fetch().asSigned()
        if jump {
            let base = Int(pc)
            let offset = Int(operand)
            pc = Address(base + offset)
        }
    }
    func bcc(mode: AddressingMode) {
        branch(!getFlag(carryMask))
    }
    func bcs(mode: AddressingMode) {
        branch(getFlag(carryMask))
    }
    func beq(mode: AddressingMode) {
        branch(getFlag(zeroMask))
    }
    func bmi(mode: AddressingMode) {
        branch(getFlag(negativeMask))
    }
    func bne(mode: AddressingMode) {
        branch(!getFlag(zeroMask))
    }
    func bpl(mode: AddressingMode) {
        branch(!getFlag(negativeMask))
    }
    func bvc(mode: AddressingMode) {
        branch(!getFlag(overflowMask))
    }
    func bvs(mode: AddressingMode) {
        branch(getFlag(overflowMask))
    }

    // Status flag operations
    func clc(mode: AddressingMode) {
        setFlag(false, carryMask)
    }
    func cld(mode: AddressingMode) {
        setFlag(false, decimalMask)
    }
    func cli(mode: AddressingMode) {
        setFlag(false, irqMask)
    }
    func clv(mode: AddressingMode) {
        setFlag(false, overflowMask)
    }
    func sec(mode: AddressingMode) {
        setFlag(true, carryMask)
    }
    func sed(mode: AddressingMode) {
        setFlag(true, decimalMask)
    }
    func sei(mode: AddressingMode) {
        setFlag(true, irqMask)
    }

    // Interrupt operations
    func brk(mode: AddressingMode) {
        let ret = pc + 1
        push(ret.highByte)
        push(ret.lowByte)
        push(flags)

        pc = mem[irqVector]
        setFlag(true, irqMask)
    }
    func rti(mode: AddressingMode) {
        flags = pop()
        pc = Address(low: pop(), high: pop())
    }

    // No operation
    func nop(mode: AddressingMode) {
    }
}
