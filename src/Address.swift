//
//  Address.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/10/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Swift already aliases Int to Word
// typealias Word = UInt16
typealias Address = UInt16

// Extract low and high bytes
extension Address {
    init (low: Byte, high: Byte) {
        self = (Address(high) << 8) & Address(low)
    }

    var lowByte: Byte {
        return Byte(self & 0xff)
    }

    var highByte: Byte {
         return Byte(self >> 8)
    }
}

// Convenience operators for incrementing/decrememting addresses by 2. I expect
// these to be quite handy because compound assignment (x+=2) is a statement rather
// than an expression returning the assigned value.

operator prefix +++ {}
operator prefix --- {}

@prefix @assignment func +++ (inout address: Address) -> Address {
    address += 2
    return address
}

@prefix @assignment func --- (inout address: Address) -> Address {
    address -= 2
    return address
}

operator postfix +++ {}
operator postfix --- {}

@postfix @assignment func +++ (inout address: Address) -> Address {
    let value = address
    address += 2
    return value
}

@postfix @assignment func --- (inout address: Address) -> Address {
    let value = address
    address -= 2
    return value
}
