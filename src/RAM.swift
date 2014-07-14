//
//  RAM.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// Simple wrapper around a byte array to implement a block of RAM

class RAM : Memory {
    var data: [Byte]
    
    init (var data: [Byte]) {
        self.data = data
    }

    convenience init (size: Int) {
        self.init(data: [Byte](count: size, repeatedValue: 0))
    }

    subscript (address: Address) -> Byte {
        get {
            return data[Int(address)]
        }
        set {
            data[Int(address)] = newValue
        }
    }
}

