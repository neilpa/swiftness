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
    
    // Number of bytes for the operands
    var bytes: Int {
        switch self {
        case Implicit: return 0
        case Accumulator: return 0
        case Immediate: return 1
        case ZeroPage: return 1
        case ZeroPageX: return 1
        case ZeroPageY: return 1
        case Relative: return 1
        case Absolute: return 2
        case AbsoluteX: return 2
        case AbsoluteY: return 2
        case Indirect: return 2
        case IndexedIndirectX: return 1
        case IndirectIndexedY: return 1
        }
    }

    func resolve (cpu: CPU) -> Slot {
        switch self {

        case .Immediate:
            return ImmediateSlot(cpu: cpu)

        case .Accumulator:
            return AccumulatorSlot(cpu: cpu)

        case .Absolute:
            return MemorySlot(addr: cpu.fetch(), mem: cpu.mem)
            
        case .AbsoluteX:
            let offset = Address(cpu.x)
            return MemorySlot(addr: cpu.fetch() + offset, mem: cpu.mem)

        case .AbsoluteY:
            let offset = Address(cpu.y)
            return MemorySlot(addr: cpu.fetch() + offset, mem: cpu.mem)

        case .ZeroPage:
            let addr: Byte = cpu.fetch()
            return MemorySlot(addr: Address(addr), mem: cpu.mem)

        case .ZeroPageX:
            let (addr, _) = Byte.addWithOverflow(cpu.fetch(), cpu.x)
            return MemorySlot(addr: Address(addr), mem: cpu.mem)

        case .ZeroPageY:
            // TODO Double check that this should wrap
            let (addr, _) = Byte.addWithOverflow(cpu.fetch(), cpu.y)
            return MemorySlot(addr: Address(addr), mem: cpu.mem)
        
        case .Indirect:
            let operand: Address = cpu.fetch()
            return MemorySlot(addr: cpu.mem[operand], mem: cpu.mem)

        case .IndexedIndirectX:
            let (offset, _) = Byte.addWithOverflow(cpu.fetch(), cpu.x)
            let addr: Address = cpu.mem[Address(offset)]
            return MemorySlot(addr: addr, mem: cpu.mem)

        case .IndirectIndexedY:
            let operand: Byte = cpu.fetch()
            let base: Address = cpu.mem[Address(operand)]
            let addr: Address = base + Address(cpu.y)
            return MemorySlot(addr: addr, mem: cpu.mem)

        // TODO Should this even exist, what about Relative?
        default:
            return NilSlot()
        }
    }
}

