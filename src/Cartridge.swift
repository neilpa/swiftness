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
    var header: [Byte] = [Byte](count: 16, repeatedValue: 0)

    // Program ROM on the cart
    let prgROM: Memory
    
    // Character ROM on the cart
    let chrROM: ROM
    
    // Path on disk to the .nes file
    init(path: String) {
        let data = NSData(contentsOfFile: path)
        data?.getBytes(&header, length: header.count)

        // TODO Avoid these allocs
        let prgBanks = Int(header[4])
        let prgBytes = prgBanks * prgChunkSize
        var bytes = [Byte](count: prgBytes, repeatedValue: 0)
        data?.getBytes(&bytes, range: NSMakeRange(header.count, prgBytes))

        // Mirror the cartridge ROM if it only has 1 memory bank
        var rom: Memory = ROM(data: bytes)
        if (prgBanks == 1) {
            rom = MemMirror(memory: rom, size: Address(prgChunkSize))
        }
        prgROM = rom;

        let chrBytes = Int(header[5]) * chrChunkSize
        bytes = [Byte](count: chrBytes, repeatedValue: 0)
        data?.getBytes(&bytes, range: NSMakeRange(header.count + prgBytes, chrBytes))
        chrROM = ROM(data: bytes)
    }
}
