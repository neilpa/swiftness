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

    convenience init (prog: [Byte]) {
        self.init(prog: prog, offset: 0)
    }

    init (prog: [Byte], offset: Int) {
        // TODO Is there a better way
        for (index, byte) in enumerate(prog) {
            data[index + offset] = byte
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
}
