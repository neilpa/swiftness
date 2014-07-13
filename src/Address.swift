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

// Hex printing helper
extension UInt16 {
    var hex: String {
        return String(format: "%04X", self)
    }
}

// Helper for low/high bytes
extension UInt16 {
    init (low: Byte, high: Byte) {
        self = Address(high) << 8 | Address(low)
    }

    var lowByte: Byte {
        return Byte(self & 0xff)
    }

    var highByte: Byte {
         return Byte(self >> 8)
    }
}
