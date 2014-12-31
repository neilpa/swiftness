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
            return MemorySlot(addr: cpu.fetchWord(), mem: cpu.mem)

        case .AbsoluteX:
            return MemorySlot(addr: cpu.fetchWord() &+ Address(cpu.x), mem: cpu.mem)

        case .AbsoluteY:
            return MemorySlot(addr: cpu.fetchWord() &+ Address(cpu.y), mem: cpu.mem)

        case .ZeroPage:
            return MemorySlot(addr: Address(cpu.fetchByte()), mem: cpu.mem)

        case .ZeroPageX:
            return MemorySlot(addr: Address(cpu.fetchByte() &+ cpu.x), mem: cpu.mem)

        case .ZeroPageY:
            return MemorySlot(addr: Address(cpu.fetchByte() &+ cpu.y), mem: cpu.mem)
        
        case .Indirect:
            return MemorySlot(addr: readWord(cpu.fetchWord(), cpu.mem), mem: cpu.mem)

        case .IndexedIndirectX:
            let addr: Address = loadZeroPage(cpu.fetchByte() &+ cpu.x, cpu)
            return MemorySlot(addr: addr, mem: cpu.mem)

        case .IndirectIndexedY:
            let base: Address = loadZeroPage(cpu.fetchByte(), cpu)
            return MemorySlot(addr: base &+ Address(cpu.y), mem: cpu.mem)
            
        // TODO Should this even exist, what about Relative?
        default:
            return NilSlot()
        }
    }
    
    // Ensures that the indirect with index modes always load from the
    // zero page. E.g. when loading a word with low byte offset of $ff
    // this wraps to load the high byte from $00 rather than $100
    func loadZeroPage(val: Byte, _ cpu: CPU) -> Address {
        let lsb: Byte = cpu.mem[Address(val)]
        let msb: Byte = cpu.mem[Address(val &+ 1)]
        return Address(low: lsb, high: msb)
    }
}
