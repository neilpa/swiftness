//
//  Disassembler.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/11/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

struct Instr {
    let opcode: Byte
    let type: Instruction
    let mode: AddressingMode

    init (_ opcode:Byte, _ type:Instruction, _ mode:AddressingMode) {
        self.opcode = opcode
        self.type = type
        self.mode = mode
    }
}

class Disassembler {
    let memory: Memory

    init (mem: Memory) {
        memory = mem
    }

    // Prints the disassembled instruction at the program counter.
    func trace(pc: Address) -> Address {
        let instr = decode(memory[pc])
        
        // Raw operand bytes
        let b1: Byte = memory[pc+1]
        let b2: Byte = memory[pc+2]
        var bytes = "     "
        switch instr.mode.bytes {
            case 2: bytes = "\(b1.hex) \(b2.hex)"
            case 1: bytes = "\(b1.hex)   "
            default: break
        }
        
        // Figure out the operand string
        let operand = "TODO"

        // Trace the instruction
        print("\(pc.hex)  \(instr.opcode.hex) \(bytes)  \(instr.type.name) \(operand)")

        return pc + Address(instr.mode.bytes) + 1
    }
 
    func decode(opcode: Byte) -> Instr {
        return instructions[Int(opcode)]
    }
    
}

// The index below matches the opcode
let instructions: [Instr] = [
    Instr( 0x00, .BRK, .Implicit ),
    Instr( 0x01, .ORA, .IndexedIndirectX ),
    Instr( 0x02, .XXX, .Implicit ),
    Instr( 0x03, .XXX, .Implicit ),
    Instr( 0x04, .NOP, .ZeroPage ), // Undocumented
    Instr( 0x05, .ORA, .ZeroPage ),
    Instr( 0x06, .ASL, .ZeroPage ),
    Instr( 0x07, .XXX, .Implicit ),
    Instr( 0x08, .PHP, .Implicit ),
    Instr( 0x09, .ORA, .Immediate ),
    Instr( 0x0A, .ASL, .Accumulator ),
    Instr( 0x0B, .XXX, .Implicit ),
    Instr( 0x0C, .NOP, .Absolute ),  // Undocumented
    Instr( 0x0D, .ORA, .Absolute ),
    Instr( 0x0E, .ASL, .Absolute ),
    Instr( 0x0F, .XXX, .Implicit ),
    Instr( 0x10, .BPL, .Relative ),
    Instr( 0x11, .ORA, .IndirectIndexedY ),
    Instr( 0x12, .XXX, .Implicit ),
    Instr( 0x13, .XXX, .Implicit ),
    Instr( 0x14, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0x15, .ORA, .ZeroPageX ),
    Instr( 0x16, .ASL, .ZeroPageX ),
    Instr( 0x17, .XXX, .Implicit ),
    Instr( 0x18, .CLC, .Implicit ),
    Instr( 0x19, .ORA, .AbsoluteY ),
    Instr( 0x1A, .NOP, .Implicit ), // Undocumented
    Instr( 0x1B, .XXX, .Implicit ),
    Instr( 0x1C, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0x1D, .ORA, .AbsoluteX ),
    Instr( 0x1E, .ASL, .AbsoluteX ),
    Instr( 0x1F, .XXX, .Implicit ),
    Instr( 0x20, .JSR, .Absolute ),
    Instr( 0x21, .AND, .IndexedIndirectX ),
    Instr( 0x22, .XXX, .Implicit ),
    Instr( 0x23, .XXX, .Implicit ),
    Instr( 0x24, .BIT, .ZeroPage ),
    Instr( 0x25, .AND, .ZeroPage ),
    Instr( 0x26, .ROL, .ZeroPage ),
    Instr( 0x27, .XXX, .Implicit ),
    Instr( 0x28, .PLP, .Implicit ),
    Instr( 0x29, .AND, .Immediate ),
    Instr( 0x2A, .ROL, .Accumulator ),
    Instr( 0x2B, .XXX, .Implicit ),
    Instr( 0x2C, .BIT, .Absolute ),
    Instr( 0x2D, .AND, .Absolute ),
    Instr( 0x2E, .ROL, .Absolute ),
    Instr( 0x2F, .XXX, .Implicit ),
    Instr( 0x30, .BMI, .Relative ),
    Instr( 0x31, .AND, .IndirectIndexedY ),
    Instr( 0x32, .XXX, .Implicit ),
    Instr( 0x33, .XXX, .Implicit ),
    Instr( 0x34, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0x35, .AND, .ZeroPageX ),
    Instr( 0x36, .ROL, .ZeroPageX ),
    Instr( 0x37, .XXX, .Implicit ),
    Instr( 0x38, .SEC, .Implicit ),
    Instr( 0x39, .AND, .AbsoluteY ),
    Instr( 0x3A, .NOP, .Implicit ), // Undocumented
    Instr( 0x3B, .XXX, .Implicit ),
    Instr( 0x3C, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0x3D, .AND, .AbsoluteX ),
    Instr( 0x3E, .ROL, .AbsoluteX ),
    Instr( 0x3F, .XXX, .Implicit ),
    Instr( 0x40, .RTI, .Implicit ),
    Instr( 0x41, .EOR, .IndexedIndirectX ),
    Instr( 0x42, .XXX, .Implicit ),
    Instr( 0x43, .XXX, .Implicit ),
    Instr( 0x44, .NOP, .ZeroPage ), // Undocumented
    Instr( 0x45, .EOR, .ZeroPage ),
    Instr( 0x46, .LSR, .ZeroPage ),
    Instr( 0x47, .XXX, .Implicit ),
    Instr( 0x48, .PHA, .Implicit ),
    Instr( 0x49, .EOR, .Immediate ),
    Instr( 0x4A, .LSR, .Accumulator ),
    Instr( 0x4B, .XXX, .Implicit ),
    Instr( 0x4C, .JMP, .Absolute ),
    Instr( 0x4D, .EOR, .Absolute ),
    Instr( 0x4E, .LSR, .Absolute ),
    Instr( 0x4F, .XXX, .Implicit ),
    Instr( 0x50, .BVC, .Relative ),
    Instr( 0x51, .EOR, .IndirectIndexedY ),
    Instr( 0x52, .XXX, .Implicit ),
    Instr( 0x53, .XXX, .Implicit ),
    Instr( 0x54, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0x55, .EOR, .ZeroPageX ),
    Instr( 0x56, .LSR, .ZeroPageX ),
    Instr( 0x57, .XXX, .Implicit ),
    Instr( 0x58, .CLI, .Implicit ),
    Instr( 0x59, .EOR, .AbsoluteY ),
    Instr( 0x5A, .NOP, .Implicit ), // Undocumented
    Instr( 0x5B, .XXX, .Implicit ),
    Instr( 0x5C, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0x5D, .EOR, .AbsoluteX ),
    Instr( 0x5E, .LSR, .AbsoluteX ),
    Instr( 0x5F, .XXX, .Implicit ),
    Instr( 0x60, .RTS, .Implicit ),
    Instr( 0x61, .ADC, .IndexedIndirectX ),
    Instr( 0x62, .XXX, .Implicit ),
    Instr( 0x63, .XXX, .Implicit ),
    Instr( 0x64, .NOP, .ZeroPage ), // Undocumented
    Instr( 0x65, .ADC, .ZeroPage ),
    Instr( 0x66, .ROR, .ZeroPage ),
    Instr( 0x67, .XXX, .Implicit ),
    Instr( 0x68, .PLA, .Implicit ),
    Instr( 0x69, .ADC, .Immediate ),
    Instr( 0x6A, .ROR, .Accumulator ),
    Instr( 0x6B, .XXX, .Implicit ),
    Instr( 0x6C, .JMP, .Indirect ),
    Instr( 0x6D, .ADC, .Absolute ),
    Instr( 0x6E, .ROR, .Absolute ),
    Instr( 0x6F, .XXX, .Implicit ),
    Instr( 0x70, .BVS, .Relative ),
    Instr( 0x71, .ADC, .IndirectIndexedY ),
    Instr( 0x72, .XXX, .Implicit ),
    Instr( 0x73, .XXX, .Implicit ),
    Instr( 0x74, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0x75, .ADC, .ZeroPageX ),
    Instr( 0x76, .ROR, .ZeroPageX ),
    Instr( 0x77, .XXX, .Implicit ),
    Instr( 0x78, .SEI, .Implicit ),
    Instr( 0x79, .ADC, .AbsoluteY ),
    Instr( 0x7A, .NOP, .Implicit ), // Undocumented
    Instr( 0x7B, .XXX, .Implicit ),
    Instr( 0x7C, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0x7D, .ADC, .AbsoluteX ),
    Instr( 0x7E, .ROR, .AbsoluteX ),
    Instr( 0x7F, .XXX, .Implicit ),
    Instr( 0x80, .NOP, .Immediate ), // Undocumented
    Instr( 0x81, .STA, .IndexedIndirectX ),
    Instr( 0x82, .XXX, .Implicit ),
    Instr( 0x83, .SAX, .IndexedIndirectX ), // Undocumented
    Instr( 0x84, .STY, .ZeroPage ),
    Instr( 0x85, .STA, .ZeroPage ),
    Instr( 0x86, .STX, .ZeroPage ),
    Instr( 0x87, .SAX, .ZeroPage ), // Undocumented
    Instr( 0x88, .DEY, .Implicit ),
    Instr( 0x89, .XXX, .Implicit ),
    Instr( 0x8A, .TXA, .Implicit ),
    Instr( 0x8B, .XXX, .Implicit ),
    Instr( 0x8C, .STY, .Absolute ),
    Instr( 0x8D, .STA, .Absolute ),
    Instr( 0x8E, .STX, .Absolute ),
    Instr( 0x8F, .SAX, .Absolute ), // Undocumented
    Instr( 0x90, .BCC, .Relative ),
    Instr( 0x91, .STA, .IndirectIndexedY ),
    Instr( 0x92, .XXX, .Implicit ),
    Instr( 0x93, .XXX, .Implicit ),
    Instr( 0x94, .STY, .ZeroPageX ),
    Instr( 0x95, .STA, .ZeroPageX ),
    Instr( 0x96, .STX, .ZeroPageY ),
    Instr( 0x97, .SAX, .ZeroPageY ), // Undocumented
    Instr( 0x98, .TYA, .Implicit ),
    Instr( 0x99, .STA, .AbsoluteY ),
    Instr( 0x9A, .TXS, .Implicit ),
    Instr( 0x9B, .XXX, .Implicit ),
    Instr( 0x9C, .XXX, .Implicit ),
    Instr( 0x9D, .STA, .AbsoluteX ),
    Instr( 0x9E, .XXX, .Implicit ),
    Instr( 0x9F, .XXX, .Implicit ),
    Instr( 0xA0, .LDY, .Immediate ),
    Instr( 0xA1, .LDA, .IndexedIndirectX ),
    Instr( 0xA2, .LDX, .Immediate ),
    Instr( 0xA3, .LAX, .IndexedIndirectX ), // Undocumented
    Instr( 0xA4, .LDY, .ZeroPage ),
    Instr( 0xA5, .LDA, .ZeroPage ),
    Instr( 0xA6, .LDX, .ZeroPage ),
    Instr( 0xA7, .LAX, .ZeroPage ), // Undocumented
    Instr( 0xA8, .TAY, .Implicit ),
    Instr( 0xA9, .LDA, .Immediate ),
    Instr( 0xAA, .TAX, .Implicit ),
    Instr( 0xAB, .XXX, .Implicit ),
    Instr( 0xAC, .LDY, .Absolute ),
    Instr( 0xAD, .LDA, .Absolute ),
    Instr( 0xAE, .LDX, .Absolute ),
    Instr( 0xAF, .LAX, .Absolute ), // Undocumented
    Instr( 0xB0, .BCS, .Relative ),
    Instr( 0xB1, .LDA, .IndirectIndexedY ),
    Instr( 0xB2, .XXX, .Implicit ),
    Instr( 0xB3, .LAX, .IndirectIndexedY ), // Undocumented
    Instr( 0xB4, .LDY, .ZeroPageX ),
    Instr( 0xB5, .LDA, .ZeroPageX ),
    Instr( 0xB6, .LDX, .ZeroPageY ),
    Instr( 0xB7, .LAX, .ZeroPageY ), // Undocumented
    Instr( 0xB8, .CLV, .Implicit ),
    Instr( 0xB9, .LDA, .AbsoluteY ),
    Instr( 0xBA, .TSX, .Implicit ),
    Instr( 0xBB, .XXX, .Implicit ),
    Instr( 0xBC, .LDY, .AbsoluteX ),
    Instr( 0xBD, .LDA, .AbsoluteX ),
    Instr( 0xBE, .LDX, .AbsoluteY ),
    Instr( 0xBF, .LAX, .AbsoluteY ), // Undocumented
    Instr( 0xC0, .CPY, .Immediate ),
    Instr( 0xC1, .CMP, .IndexedIndirectX ),
    Instr( 0xC2, .XXX, .Implicit ),
    Instr( 0xC3, .XXX, .Implicit ),
    Instr( 0xC4, .CPY, .ZeroPage ),
    Instr( 0xC5, .CMP, .ZeroPage ),
    Instr( 0xC6, .DEC, .ZeroPage ),
    Instr( 0xC7, .XXX, .Implicit ),
    Instr( 0xC8, .INY, .Implicit ),
    Instr( 0xC9, .CMP, .Immediate ),
    Instr( 0xCA, .DEX, .Implicit ),
    Instr( 0xCB, .XXX, .Implicit ),
    Instr( 0xCC, .CPY, .Absolute ),
    Instr( 0xCD, .CMP, .Absolute ),
    Instr( 0xCE, .DEC, .Absolute ),
    Instr( 0xCF, .XXX, .Implicit ),
    Instr( 0xD0, .BNE, .Relative ),
    Instr( 0xD1, .CMP, .IndirectIndexedY ),
    Instr( 0xD2, .XXX, .Implicit ),
    Instr( 0xD3, .XXX, .Implicit ),
    Instr( 0xD4, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0xD5, .CMP, .ZeroPageX ),
    Instr( 0xD6, .DEC, .ZeroPageX ),
    Instr( 0xD7, .XXX, .Implicit ),
    Instr( 0xD8, .CLD, .Implicit ),
    Instr( 0xD9, .CMP, .AbsoluteY ),
    Instr( 0xDA, .NOP, .Implicit ), // Undocumented
    Instr( 0xDB, .XXX, .Implicit ),
    Instr( 0xDC, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0xDD, .CMP, .AbsoluteX ),
    Instr( 0xDE, .DEC, .AbsoluteX ),
    Instr( 0xDF, .XXX, .Implicit ),
    Instr( 0xE0, .CPX, .Immediate ),
    Instr( 0xE1, .SBC, .IndexedIndirectX ),
    Instr( 0xE2, .XXX, .Implicit ),
    Instr( 0xE3, .XXX, .Implicit ),
    Instr( 0xE4, .CPX, .ZeroPage ),
    Instr( 0xE5, .SBC, .ZeroPage ),
    Instr( 0xE6, .INC, .ZeroPage ),
    Instr( 0xE7, .XXX, .Implicit ),
    Instr( 0xE8, .INX, .Implicit ),
    Instr( 0xE9, .SBC, .Immediate ),
    Instr( 0xEA, .NOP, .Implicit ),
    Instr( 0xEB, .SBC, .Immediate ), // Undocumented
    Instr( 0xEC, .CPX, .Absolute ),
    Instr( 0xED, .SBC, .Absolute ),
    Instr( 0xEE, .INC, .Absolute ),
    Instr( 0xEF, .XXX, .Implicit ),
    Instr( 0xF0, .BEQ, .Relative ),
    Instr( 0xF1, .SBC, .IndirectIndexedY ),
    Instr( 0xF2, .XXX, .Implicit ),
    Instr( 0xF3, .XXX, .Implicit ),
    Instr( 0xF4, .NOP, .ZeroPageX ), // Undocumented
    Instr( 0xF5, .SBC, .ZeroPageX ),
    Instr( 0xF6, .INC, .ZeroPageX ),
    Instr( 0xF7, .XXX, .Implicit ),
    Instr( 0xF8, .SED, .Implicit ),
    Instr( 0xF9, .SBC, .AbsoluteY ),
    Instr( 0xFA, .NOP, .Implicit ), // Undocumented
    Instr( 0xFB, .XXX, .Implicit ),
    Instr( 0xFC, .NOP, .AbsoluteX ), // Undocumented
    Instr( 0xFD, .SBC, .AbsoluteX ),
    Instr( 0xFE, .INC, .AbsoluteX ),
    Instr( 0xFF, .XXX, .Implicit ),
]
