//
//  Memory.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/9/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

protocol Memory {
    // Load/Store a byte
    subscript (address: UInt16) -> UInt8 { get set }
    
    // Convenience for load/store a word
    subscript (address: UInt16) -> UInt16 { get set }
//    func loadWord (address: UInt16) -> UInt16
//    func storeWord (address: UInt16, _ value: UInt16)
}
