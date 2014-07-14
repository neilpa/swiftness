//
//  ROM.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple wrapper around a byte array to implement a block of ROM

// TODO This is nearly identical to RAM
class ROM : Memory {
    let data: [Byte]

    init (data: [Byte]) {
        self.data = data
    }

    convenience init (size: Int) {
        self.init(data: [Byte](count: size, repeatedValue: 0))
    }

    subscript (addr: Address) -> Byte {
        get {
            return data[Int(addr)]
        }
        set {
            assert(false, "Invalid write to ROM")
        }
    }
}

