//
//  RAM.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple 64KB of memory module

class RAM : Memory {
    var data: UInt8[] = UInt8[](count:2^16, repeatedValue:0)
    
    subscript (address: UInt16) -> UInt8 {
        get {
            return data[Int(address)]
        }
        set {
            data[Int(address)] = newValue
        }
    }
    
    subscript (address: UInt16) -> UInt16 {
        get {
            let lsb = data[Int(address)]
            let msb = data[Int(address+1)]
            return UInt16(msb) << 8 | UInt16(lsb)
        }
        set {
            data[Int(address)] = UInt8(newValue)
            data[Int(address+1)] = UInt8(newValue >> 8)
        }
    }
}

