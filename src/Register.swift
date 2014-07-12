//
//  Register.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/10/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

typealias Byte = UInt8
typealias Register = Byte

// Hex printing helper
extension Byte {
    var hex: String {
        return String(format: "%02X", self)
    }
}