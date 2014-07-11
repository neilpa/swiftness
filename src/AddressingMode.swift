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

    func resolve (cpu: CPU) -> Slot {
        switch self {
        case .Immediate: return ImmediateSlot(cpu: cpu)
        case .Accumulator: return AccumulatorSlot(cpu: cpu)

        case .Absolute:
            return MemorySlot(addr: cpu.fetch(), mem: cpu.mem)

        // TODO Implement the different memory slots
        // case .ZeroPage:
        // case .ZeroPageX:
        // case .ZeroPageY:
        // case .Relative:
        // case .Absolute:
        // case .AbsoluteX:
        // case .AbsoluteY:
        // case .Indirect:
        // case .IndexedIndirectX:
        // case .IndirectIndexedY:

        // TODO Should this even exist?
        default: return NilSlot()
        }
    }
}

// e.g mail slot since we're talking about addresses
protocol Slot {
    func load() -> Byte
    func store(val: Byte)
}

class NilSlot : Slot {
    func load() -> Byte {
        assert(false, "Invalid slot")
        return 0
    }
    
    func store(val: Byte) {
        assert(false, "Invalid slot")
    }
}

class ImmediateSlot : Slot {
    let cpu: CPU
    init(cpu: CPU) {
        self.cpu = cpu
    }

    // TODO Should this be resolved immediately and cached?
    func load() -> Byte {
        return cpu.fetch()
    }
    
    func store(val: Byte) {
        assert(false, "Immediates are read only")
    }
}

class AccumulatorSlot : Slot {
    let cpu: CPU

    init(cpu: CPU) {
        self.cpu = cpu
    }

    func load() -> Byte {
        return self.cpu.a
    }
    
    func store(val: Byte) {
        self.cpu.a = val
    }
}

class MemorySlot : Slot {
    let address: Address
    var memory: Memory

    init(addr: Address, mem: Memory) {
        address = addr
        memory = mem
    }

    func load() -> Byte {
        return memory[address]
    }
    
    func store(val: Byte) {
        memory[address] = val
    }
}
