//
//  RAM.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple 64KB of memory module

class RAM : Memory {
    var data: UInt8[] = UInt8[](count:66000, repeatedValue:0)

    init (prog: UInt8[]) {
        // TODO Is there a better way
        for (index, byte) in enumerate(prog) {
            data[index] = byte
        }
    }
    
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
            let res = UInt16(msb) << 8 | UInt16(lsb)
            return res
        }
        set {
            data[Int(address)] = UInt8(newValue)
            data[Int(address+1)] = UInt8(newValue >> 8)
        }
    }
}

