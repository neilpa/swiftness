//
//  RAM.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple 64KB of memory module

class RAM : Memory {
    var data: [Byte] = [Byte](count:66000, repeatedValue:0)

    init (prog: [Byte]) {
        // TODO Is there a better way
        for (index, byte) in enumerate(prog) {
            data[index] = byte
        }
    }
    
    subscript (address: Address) -> Byte {
        get {
            return data[Int(address)]
        }
        set {
            data[Int(address)] = newValue
        }
    }

    subscript (address: Address) -> UInt16 {
        get {
            let lsb = data[Int(address)]
            let msb = data[Int(address+1)]
            return UInt16(msb) << 8 | UInt16(lsb)
        }
        set {
            data[Int(address)] = Byte(newValue)
            data[Int(address+1)] = Byte(newValue >> 8)
        }
    }
}

