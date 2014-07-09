//
//  Instruction.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

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
}
