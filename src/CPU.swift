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
    func decode(opcode: Byte) -> (Instruction, AddressingMode) {
        return instructionSet[Int(opcode)]
    }

    // The fetch-decode-execute loop
    func run() {
        while (true) {
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
        a = setNZ(mode.load(self))
    }
    func ldx(mode: AddressingMode) {
        x = setNZ(mode.load(self))
    }
    func ldy(mode: AddressingMode) {
        y = setNZ(mode.load(self))
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
        x = setNZ(a)
    }
    func tay(mode: AddressingMode) {
        assert(mode == .Implicit)
        y = setNZ(a)
    }
    func txa(mode: AddressingMode) {
        assert(mode == .Implicit)
        a = setNZ(x)
    }
    func tya(mode: AddressingMode) {
        assert(mode == .Implicit)
        a = setNZ(y)
    }
    func tsx(mode: AddressingMode) {
        assert(mode == .Implicit)
        x = setNZ(sp)
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
        a = setNZ(a & mode.load(self))
    }
    func eor(mode: AddressingMode) {
        a = setNZ(a ^ mode.load(self))
    }
    func ora(mode: AddressingMode) {
        a = setNZ(a | mode.load(self))
    }
    func bit(mode: AddressingMode) {
        assert(false, "Not implemented")
        let val = mode.load(self)
        setFlag(val & a == 0, zeroMask)
        setFlag(val & 0x80 != 0, negativeMask)
        setFlag(val & 0x40 != 0, overflowMask)
    }

    // Arithmetic operations
    // TODO adc and sbc are identical except for addWithOverflow/subtractWithOverflow
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
        a = setNZ(res)
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
        a = setNZ(res)
    }

    // Comparison operations
    func compare(mode: AddressingMode, _ reg: Register) {
        let val = mode.load(self)
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
        // TODO addressing mode delegation breaks down here. Need to capture the
        // original address for the load/store combo to work here
        assert(false, "Not implemented")
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
        // TODO addressing mode delegation breaks down here. Need to capture the
        // original address for the load/store combo to work here
        assert(false, "Not implemented")
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
    // TODO addressing mode delegation breaks down here. Need to capture the
    // original address for the load/store combo to work here
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
