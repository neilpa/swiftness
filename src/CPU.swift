//
//  CPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Flags in the processor status register
let negativeMask:   Byte = 1 << 7
let overflowMask:   Byte = 1 << 6
let decimalMask:    Byte = 1 << 3
let irqMask:        Byte = 1 << 2
let zeroMask:       Byte = 1 << 1
let carryMask:      Byte = 1 << 0

// See http://wiki.nesdev.com/w/index.php/Status_flags
// This isn't a real status flag. This bit is set on the value pushed to the
// stack when executing a PHP or BRK instruction and not during NMI.
let brkMask: Byte = 1 << 4

// Bit 5 is reserved and always set in the status flags
let defaultFlags: Byte = 1 << 5

let stackOffset: Address = 0x0100

let nmiVector:   Address = 0xfffa
let resetVector: Address = 0xfffc
let irqVector:   Address = 0xfffe

class CPU {
    
    // Turn instruction tracing on/off
    var trace = false

    // General purpose registers
    var a: Register = 0 // accumulator
    var x: Register = 0 // x indexer
    var y: Register = 0 // y indexer

    // Stack pointer starts at the top and grows down
    var sp: Register = 0xfd

    // Processor status flags register
    var flags: Register = defaultFlags | irqMask | brkMask

    // Program counter register
    var pc: Address = 0

    // Memory
    var mem: Memory
    
    // Disassembler for decoding/tracing instructions
    var disassembler: Disassembler

    init(memory: Memory) {
        mem = memory
        disassembler = Disassembler(mem: memory)
        pc = readWord(resetVector, mem)
    }

    // Register helpers

    // Get a bit from the status register
    func getFlag(mask: Byte) -> Bool {
        return flags & mask != 0
    }

    // Set or clear a bit in the status register
    func setFlag(isSet: Bool, _ mask: Byte) {
        assert(mask != brkMask, "Invalid mask")

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
    func popFlags() {
        // Ensures the BRK and expansion flags are correct regardless of the
        // value that we pop off the stack
        flags = pop() & ~brkMask | defaultFlags
    }

    // Fetch opcode or arguments at PC and increment
    func fetchByte() -> Byte {
        return mem[pc++]
    }
    func fetchWord() -> UInt16 {
        let val = readWord(pc, mem)
        pc += 2
        return val
    }

    // Decode the operation
    func decode(opcode: Byte) -> (Instruction, AddressingMode) {
        let instr = disassembler.decode(opcode)
        return (instr.type, instr.mode)
    }
    
    // Step a single fetch-decode-execute cycle
    func step() {
        if trace {
            disassembler.trace(pc)
            println(String(format:"  A:%02X X:%02X Y:%02X P:%02X SP:%02X", a, x, y, flags, sp))
        }

        let code: Byte = fetchByte()
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

        // Undocumented instructions
        case .LAX: lax(mode)
        case .SAX: sax(mode)
            
        default: assert(false, "Unrecognized opcode")
        }
    }
}

// Instructions

// N.B. from http://nesdev.com/NinTech.txt
// - Read Modify Write instructions (inc, asl etc) will read, write back the same value then
//   modify and write the right value to the memory address. Beware of the dummy write.
// - Any kind of Index will have a dummy read before fixing high address byte
// - BRK is 2 bytes

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
    func pla(mode: AddressingMode) {
        a = setNZ(pop())
    }
    func php(mode: AddressingMode) {
        push(flags | brkMask)
    }
    func plp(mode: AddressingMode) {
        popFlags()
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
    func addition(val: Byte) {
        // Let Swift figure out carry and overflow
        var (res, carry) = Byte.addWithOverflow(a, val)
        var (signed, overflow) = Int8.addWithOverflow(Int8(bitPattern: a), Int8(bitPattern: val))
        
        // Check if that final bit pushes us over the top
        if (getFlag(carryMask)) {
            if !carry {
                (res, carry) = Byte.addWithOverflow(res, 1)
            } else {
                // Already, one more bit isn't going to change that
                res = res &+ 1
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
    func adc(mode: AddressingMode) {
        addition(mode.resolve(self).load())
    }
    // SBC can be implemented in terms of ADC
    // http://forums.nesdev.com/viewtopic.php?p=19080
    func sbc(mode: AddressingMode) {
        addition(mode.resolve(self).load() ^ 0xff)
    }

    // Comparison operations
    func compare(mode: AddressingMode, _ reg: Register) {
        let val = mode.resolve(self).load()
        setFlag(reg >= val, carryMask)
        setNZ(reg &- val)
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
        slot.store(setNZ(slot.load() &+ 1))
    }
    func inx(mode: AddressingMode) {
        x = setNZ(x &+ 1)
    }
    func iny(mode: AddressingMode) {
        y = setNZ(y &+ 1)
    }

    // Decrement operations
    func dec(mode: AddressingMode) {
        let slot = mode.resolve(self)
        slot.store(setNZ(slot.load() &- 1))
    }
    func dex(mode: AddressingMode) {
        x = setNZ(x &- 1)
    }
    func dey(mode: AddressingMode) {
        y = setNZ(y &- 1)
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
            res |= 0x01
        }
        setFlag(val & 0x80 != 0, carryMask)
        slot.store(setNZ(res))
    }
    func ror(mode: AddressingMode) {
        let slot = mode.resolve(self)
        let val = slot.load()
        var res = val >> 1
        if (getFlag(carryMask)) {
            res |= 0x80
        }
        setFlag(val & 0x01 != 0, carryMask)
        slot.store(setNZ(res))
    }

    // Jump operations
    func jmp(mode: AddressingMode) {
        var addr: Address = fetchWord()
        if (mode == AddressingMode.Indirect) {
            // Replicate the page boundary bug for indirect jumps
            let lsb: Byte = mem[addr]
            var msb: Byte = mem[addr + 1]
            if addr & 0xff == 0xff {
                msb = mem[addr & 0xff00]
            }
            addr = Address(low: lsb, high: msb)
        }
        pc = addr
    }

    // Call operations
    func jsr(mode: AddressingMode) {
        let addr = fetchWord()
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
        let operand = Int8(bitPattern: fetchByte())
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
        push(flags | brkMask)

        pc = readWord(irqVector, mem)
        setFlag(true, irqMask)
    }
    func rti(mode: AddressingMode) {
        popFlags()
        pc = Address(low: pop(), high: pop())
    }

    // No operation
    func nop(mode: AddressingMode) {
        // Undocumented NOPs have operands that need to be eaten
        if (mode != .Implicit) {
            mode.resolve(self).load()
        }
    }
    
    // Undocumented operations
    func lax(mode: AddressingMode) {
        a = setNZ(mode.resolve(self).load())
        x = a
    }
    func sax(mode: AddressingMode) {
        // TODO Conflicting reports as to whether this affects N&Z status registers
        // http://www.ataripreservation.org/websites/freddy.offenga/illopc31.txt
        // http://wiki.nesdev.com/w/index.php/Programming_with_unofficial_opcodes
        mode.resolve(self).store(a & x)
    }

    // TODO Taking the mode for these is going to mess up state
    func dcp(mode: AddressingMode) {
        assert(false, "Not implemented")
//        dec(mode);
//        cmp(mode);
    }
    func isb(mode: AddressingMode) {
        assert(false, "Not implemented")
//        inc(mode);
//        sbc(mode);
    }
    func slo(mode: AddressingMode) {
        assert(false, "Not implemented")
//        asl(mode);
//        ora(mode);
    }
    func rla(mode: AddressingMode) {
        assert(false, "Not implemented")
//        rol(mode);
//        and(mode);
    }
    func sre(mode: AddressingMode) {
        assert(false, "Not implemented")
//        lsr(mode);
//        eor(mode);
    }
    func rra(mode: AddressingMode) {
        assert(false, "Not implemented")
//        ror(mode);
//        adc(mode);
    }
}
