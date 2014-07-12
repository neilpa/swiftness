//
//  Memory.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

protocol Memory {
    // Load/Store a byte
    subscript (address: Address) -> Byte { get set }
    
    // Convenience for load/store a word
    // TODO Remove since this causes too much ambiguity with above
    subscript (address: Address) -> UInt16 { get set }
}
