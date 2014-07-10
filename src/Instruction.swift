//
//  Instruction.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

enum Instruction {
    case ADC    // Add Memory to Accumulator with Carry
    case AND    // "AND" Memory with Accumulator
    case ASL    // Shift Left One Bit (Memory or Accumulator)

    case BCC    // Branch on Carry Clear
    case BCS    // Branch on Carry Set
    case BEQ    // Branch on Result Zero
    case BIT    // Test Bits in Memory with Accumulator
    case BMI    // Branch on Result Minus
    case BNE    // Branch on Result not Zero
    case BPL    // Branch on Result Plus
    case BRK    // Force Break
    case BVC    // Branch on Overflow Clear
    case BVS    // Branch on Overflow Set

    case CLC    // Clear Carry Flag
    case CLD    // Clear Decimal Mode
    case CLI    // Clear interrupt Disable Bit
    case CLV    // Clear Overflow Flag
    case CMP    // Compare Memory and Accumulator
    case CPX    // Compare Memory and Index X
    case CPY    // Compare Memory and Index Y

    case DEC    // Decrement Memory by One
    case DEX    // Decrement Index X by One
    case DEY    // Decrement Index Y by One

    case EOR    // "Exclusive-Or" Memory with Accumulator

    case INC    // Increment Memory by One
    case INX    // Increment Index X by One
    case INY    // Increment Index Y by One

    case JMP    // Jump to New Location
    case JSR    // Jump to New Location Saving Return Address

    case LDA    // Load Accumulator with Memory
    case LDX    // Load Index X with Memory
    case LDY    // Load Index Y with Memory
    case LSR    // Shift Right One Bit (Memory or Accumulator)

    case NOP    // No Operation

    case ORA    // "OR" Memory with Accumulator

    case PHA    // Push Accumulator on Stack
    case PHP    // Push Processor Status on Stack
    case PLA    // Pull Accumulator from Stack
    case PLP    // Pull Processor Status from Stack

    case ROL    // Rotate One Bit Left (Memory or Accumulator)
    case ROR    // Rotate One Bit Right (Memory or Accumulator)
    case RTI    // Return from Interrupt
    case RTS    // Return from Subroutine

    case SBC    // Subtract Memory from Accumulator with Borrow
    case SEC    // Set Carry Flag
    case SED    // Set Decimal Mode
    case SEI    // Set Interrupt Disable Status
    case STA    // Store Accumulator in Memory
    case STX    // Store Index X in Memory
    case STY    // Store Index Y in Memory

    case TAX    // Transfer Accumulator to Index X
    case TAY    // Transfer Accumulator to Index Y
    case TSX    // Transfer Stack Pointer to Index X
    case TXA    // Transfer Index X to Accumulator
    case TXS    // Transfer Index X to Stack Pointer
    case TYA    // Transfer Index Y to Accumulator

    // TODO Remove and use an optional tuple below?
    case INVALID
}

// The index corresponds to the opcode
let instructionSet: (Instruction, AddressingMode)[] = [

    ( .BRK, .Implicit ),
    ( .ORA, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ORA, .ZeroPage ),
    ( .ASL, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .PHP, .Implicit ),
    ( .ORA, .Immediate ),
    ( .ASL, .Accumulator ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ORA, .Absolute ),
    ( .ASL, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BPL, .Implicit ),
    ( .ORA, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ORA, .ZeroPageX ),
    ( .ASL, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .CLC, .Implicit ),
    ( .ORA, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ORA, .AbsoluteX ),
    ( .ASL, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .JSR, .Implicit ),
    ( .AND, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .BIT, .ZeroPage ),
    ( .AND, .ZeroPage ),
    ( .ROL, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .PLP, .Implicit ),
    ( .AND, .Immediate ),
    ( .ROL, .Accumulator ),
    ( .INVALID, .Implicit ),
    ( .BIT, .Absolute ),
    ( .AND, .Absolute ),
    ( .ROL, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BMI, .Implicit ),
    ( .AND, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .AND, .ZeroPageX ),
    ( .ROL, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .SEC, .Implicit ),
    ( .AND, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .AND, .AbsoluteX ),
    ( .ROL, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .RTI, .Implicit ),
    ( .EOR, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .EOR, .ZeroPage ),
    ( .LSR, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .PHA, .Implicit ),
    ( .EOR, .Immediate ),
    ( .LSR, .Accumulator ),
    ( .INVALID, .Implicit ),
    ( .JMP, .Absolute ),
    ( .EOR, .Absolute ),
    ( .LSR, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BVC, .Implicit ),
    ( .EOR, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .EOR, .ZeroPageX ),
    ( .LSR, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .CLI, .Implicit ),
    ( .EOR, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .EOR, .AbsoluteX ),
    ( .LSR, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .RTS, .Implicit ),
    ( .ADC, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ADC, .ZeroPage ),
    ( .ROR, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .PLA, .Implicit ),
    ( .ADC, .Immediate ),
    ( .ROR, .Accumulator ),
    ( .INVALID, .Implicit ),
    ( .JMP, .Indirect ),
    ( .ADC, .Absolute ),
    ( .ROR, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BVS, .Implicit ),
    ( .ADC, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ADC, .ZeroPageX ),
    ( .ROR, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .SEI, .Implicit ),
    ( .ADC, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .ADC, .AbsoluteX ),
    ( .ROR, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .STA, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .STY, .ZeroPage ),
    ( .STA, .ZeroPage ),
    ( .STX, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .DEY, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .TXA, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .STY, .Absolute ),
    ( .STA, .Absolute ),
    ( .STX, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BCC, .Implicit ),
    ( .STA, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .STY, .ZeroPageX ),
    ( .STA, .ZeroPageX ),
    ( .STX, .ZeroPageY ),
    ( .INVALID, .Implicit ),
    ( .TYA, .Implicit ),
    ( .STA, .AbsoluteY ),
    ( .TXS, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .STA, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .LDY, .Immediate ),
    ( .LDA, .IndexedIndirectX ),
    ( .LDX, .Immediate ),
    ( .INVALID, .Implicit ),
    ( .LDY, .ZeroPage ),
    ( .LDA, .ZeroPage ),
    ( .LDX, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .TAY, .Implicit ),
    ( .LDA, .Immediate ),
    ( .TAX, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .LDY, .Absolute ),
    ( .LDA, .Absolute ),
    ( .LDX, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BCS, .Implicit ),
    ( .LDA, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .LDY, .ZeroPageX ),
    ( .LDA, .ZeroPageX ),
    ( .LDX, .ZeroPageY ),
    ( .INVALID, .Implicit ),
    ( .CLV, .Implicit ),
    ( .LDA, .AbsoluteY ),
    ( .TSX, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .LDY, .AbsoluteX ),
    ( .LDA, .AbsoluteX ),
    ( .LDX, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .CPY, .Immediate ),
    ( .CMP, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CPY, .ZeroPage ),
    ( .CMP, .ZeroPage ),
    ( .DEC, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .INY, .Implicit ),
    ( .CMP, .Immediate ),
    ( .DEX, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CPY, .Absolute ),
    ( .CMP, .Absolute ),
    ( .DEC, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BNE, .Implicit ),
    ( .CMP, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CMP, .ZeroPageX ),
    ( .DEC, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .CLD, .Implicit ),
    ( .CMP, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CMP, .AbsoluteX ),
    ( .DEC, .AbsoluteX ),
    ( .INVALID, .Implicit ),
    ( .CPX, .Immediate ),
    ( .SBC, .IndexedIndirectX ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CPX, .ZeroPage ),
    ( .SBC, .ZeroPage ),
    ( .INC, .ZeroPage ),
    ( .INVALID, .Implicit ),
    ( .INX, .Implicit ),
    ( .SBC, .Immediate ),
    ( .NOP, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .CPX, .Absolute ),
    ( .SBC, .Absolute ),
    ( .INC, .Absolute ),
    ( .INVALID, .Implicit ),
    ( .BEQ, .Implicit ),
    ( .SBC, .IndirectIndexedY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .SBC, .ZeroPageX ),
    ( .INC, .ZeroPageX ),
    ( .INVALID, .Implicit ),
    ( .SED, .Implicit ),
    ( .SBC, .AbsoluteY ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .INVALID, .Implicit ),
    ( .SBC, .AbsoluteX ),
    ( .INC, .AbsoluteX ),
    ( .INVALID, .Implicit ),

]
