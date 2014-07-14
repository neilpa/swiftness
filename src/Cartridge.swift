//
//  Cartridge.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Foundation

let prgChunkSize = 16 * 1024
let chrChunkSize = 8 * 1024

class Cartridge {
    
    // The 16-byte iNES header
    let header: [Byte] = [Byte](count: 16, repeatedValue: 0)

    // Program ROM on the cart
    let prgROM: [Byte]
    
    // Character ROM on the cart
    let chrROM: [Byte]
    
    // Path on disk to the .nes file
    init(path: String) {
        let data = NSData(contentsOfFile: path)
        data.getBytes(&header, length: header.count)
        
        // TODO Avoid these allocs
        let prgBytes = Int(header[4]) * prgChunkSize
        prgROM = [Byte](count: prgBytes, repeatedValue: 0)
        data.getBytes(&prgROM, range: NSMakeRange(header.count, prgBytes))
        
        let chrBytes = Int(header[5]) * chrChunkSize
        chrROM = [Byte](count: chrBytes, repeatedValue: 0)
        data.getBytes(&chrROM, range: NSMakeRange(header.count + prgBytes, chrBytes))
    }
}