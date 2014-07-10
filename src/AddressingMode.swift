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
}
