//
//  AddressingMode.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

enum AddressingMode {
    case Implicit
    case Accumulator
    case Immediate
    case ZeroPage
    case ZeroPageX
    case ZeroPageY
    case Relative
    case Absolute
    case AbsoluteX
    case AbsoluteY
    case Indirect
    case IndexedIndirectX
    case IndirectIndexedY

    func load (cpu: CPU) -> UInt8 {
        switch self {
            
        case .Immediate: return cpu.fetch()
            
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
    
    func store (cpu: CPU, _ value: UInt8) {
        
        switch self {
            
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
}
