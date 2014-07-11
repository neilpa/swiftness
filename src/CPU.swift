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
    func setNZ(val: Byte) -> Byte {
        setFlag(val == 0, zeroMask)
        setFlag(val & 0x80 != 0, negativeMask)
        return val
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
    func decode(opcode: Byte) -> (Instruction, Slot) {
        let (instruction, mode) = instructionSet[Int(opcode)]
        return (instruction, mode.resolve(self))
    }

    // Step a single fetch-decode-execute cycle
    func step() {
        let code: Byte = fetch()
        let (instruction, slot) = decode(code)

        switch instruction {
        case .ADC: adc(slot)
        case .AND: and(slot)
        case .ASL: asl(slot)
        case .BCC: bcc(slot)
        case .BCS: bcs(slot)
        case .BEQ: beq(slot)
        case .BIT: bit(slot)
        case .BMI: bmi(slot)
        case .BNE: bne(slot)
        case .BPL: bpl(slot)
        case .BRK: brk(slot)
        case .BVC: bvc(slot)
        case .BVS: bvs(slot)
        case .CLC: clc(slot)
        case .CLD: cld(slot)
        case .CLI: cli(slot)
        case .CLV: clv(slot)
        case .CMP: cmp(slot)
        case .CPX: cpx(slot)
        case .CPY: cpy(slot)
        case .DEC: dec(slot)
        case .DEX: dex(slot)
        case .DEY: dey(slot)
        case .EOR: eor(slot)
        case .INC: inc(slot)
        case .INX: inx(slot)
        case .INY: iny(slot)
        case .JMP: jmp(slot)
        case .JSR: jsr(slot)
        case .LDA: lda(slot)
        case .LDX: ldx(slot)
        case .LDY: ldy(slot)
        case .LSR: lsr(slot)
        case .NOP: nop(slot)
        case .ORA: ora(slot)
        case .PHA: pha(slot)
        case .PHP: php(slot)
        case .PLA: pla(slot)
        case .PLP: plp(slot)
        case .ROL: rol(slot)
        case .ROR: ror(slot)
        case .RTI: rti(slot)
        case .RTS: rts(slot)
        case .SBC: sbc(slot)
        case .SEC: sec(slot)
        case .SED: sed(slot)
        case .SEI: sei(slot)
        case .STA: sta(slot)
        case .STX: stx(slot)
        case .STY: sty(slot)
        case .TAX: tax(slot)
        case .TAY: tay(slot)
        case .TSX: tsx(slot)
        case .TXA: txa(slot)
        case .TXS: txs(slot)
        case .TYA: tya(slot)
        default: assert(false, "Unrecognized opcode")
        }
    }
}

// Instructions

extension CPU {

    // Load operations
    func lda(slot: Slot) {
        a = setNZ(slot.load())
    }
    func ldx(slot: Slot) {
        x = setNZ(slot.load())
    }
    func ldy(slot: Slot) {
        y = setNZ(slot.load())
    }

    // Store operations
    func sta(slot: Slot) {
        slot.store(a)
    }
    func stx(slot: Slot) {
        slot.store(x)
    }
    func sty(slot: Slot) {
        slot.store(y)
    }

    // Register transfer operations
    func tax(slot: Slot) {
        x = setNZ(a)
    }
    func tay(slot: Slot) {
        y = setNZ(a)
    }
    func txa(slot: Slot) {
        a = setNZ(x)
    }
    func tya(slot: Slot) {
        a = setNZ(y)
    }
    func tsx(slot: Slot) {
        x = setNZ(sp)
    }
    func txs(slot: Slot) {
        sp = x
    }

    // Stack operations
    func pha(slot: Slot) {
        push(a)
    }
    func php(slot: Slot) {
        push(flags)
    }
    func pla(slot: Slot) {
        a = pop()
    }
    func plp(slot: Slot) {
        flags = pop()
    }

    // Logical operations
    func and(slot: Slot) {
        a = setNZ(a & slot.load())
    }
    func eor(slot: Slot) {
        a = setNZ(a ^ slot.load())
    }
    func ora(slot: Slot) {
        a = setNZ(a | slot.load())
    }
    func bit(slot: Slot) {
        let val = slot.load()
        setFlag(val & a == 0, zeroMask)
        setFlag(val & 0x80 != 0, negativeMask)
        setFlag(val & 0x40 != 0, overflowMask)
    }

    // Arithmetic operations
    // TODO adc and sbc are identical except for addWithOverflow/subtractWithOverflow
    func adc(slot: Slot) {
        let val = slot.load()

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
    func sbc(slot: Slot) {
        let val = slot.load()

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
    func compare(slot: Slot, _ reg: Register) {
        let val = slot.load()
        setFlag(reg >= val, carryMask)

        let (res, _) = Byte.subtractWithOverflow(reg, val)
        setNZ(res)
    }
    func cmp(slot: Slot) {
        compare(slot, a)
    }
    func cpx(slot: Slot) {
        compare(slot, x)
    }
    func cpy(slot: Slot) {
        compare(slot, y)
    }

    // Increment operations
    func inc(slot: Slot) {
        assert(false, "Not implemented")
    }
    func inx(slot: Slot) {
        let (res, _) = Byte.addWithOverflow(x, 1)
        x = setNZ(res)
    }
    func iny(slot: Slot) {
        let (res, _) = Byte.addWithOverflow(y, 1)
        y = setNZ(res)
    }

    // Decrement operations
    func dec(slot: Slot) {
        assert(false, "Not implemented")
    }
    func dex(slot: Slot) {
        let (res, _) = Byte.subtractWithOverflow(x, 1)
        x = setNZ(res)
    }
    func dey(slot: Slot) {
        let (res, _) = Byte.subtractWithOverflow(y, 1)
        y = setNZ(res)
    }

    // Shift operations
    func asl(slot: Slot) {
        assert(false, "Not implemented")
    }
    func lsr(slot: Slot) {
        assert(false, "Not implemented")
    }
    func rol(slot: Slot) {
        assert(false, "Not implemented")
    }
    func ror(slot: Slot) {
        assert(false, "Not implemented")
    }

    // Jump operations
    func jmp(slot: Slot) {
        assert(false, "Not implemented")
    }

    // Call operations
    func jsr(slot: Slot) {
        assert(false, "Not implemented")
    }
    func rts(slot: Slot) {
        assert(false, "Not implemented")
    }

    // Branch operations
    func bcc(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bcs(slot: Slot) {
        assert(false, "Not implemented")
    }
    func beq(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bmi(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bne(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bpl(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bvc(slot: Slot) {
        assert(false, "Not implemented")
    }
    func bvs(slot: Slot) {
        assert(false, "Not implemented")
    }

    // Status flag operations
    func clc(slot: Slot) {
        setFlag(false, carryMask)
    }
    func cld(slot: Slot) {
        setFlag(false, decimalMask)
    }
    func cli(slot: Slot) {
        setFlag(false, irqMask)
    }
    func clv(slot: Slot) {
        setFlag(false, overflowMask)
    }
    func sec(slot: Slot) {
        setFlag(true, carryMask)
    }
    func sed(slot: Slot) {
        setFlag(true, decimalMask)
    }
    func sei(slot: Slot) {
        setFlag(true, irqMask)
    }

    // System operations
    func brk(slot: Slot) {
        assert(false, "Not implemented")
    }
    func nop(slot: Slot) {
        assert(false, "Not implemented")
    }
    func rti(slot: Slot) {
        assert(false, "Not implemented")
    }

}
