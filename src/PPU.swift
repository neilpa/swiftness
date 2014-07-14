//
//  PPU.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/13/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

// The NES Picture Processing Unit

class PPU {

    // PPU Registers (mapped to $2000-$2007 of CPU memory)

    var control1: Register = 0 // $2000
    var control2: Register = 0 // $2001

    var status: Register = 0 // $2002

    var spriteIndex: Register = 0 // $2003
    // TODO Do I actually need a register for this?
    var spriteData: Register = 0 // $2004

    var scrollOffsets: Register = 0 // $2005

    var memoryAddress: Register = 0 // $2006
    // TODO Do I actually need a register for this?
    var memroyData: Register = 0 // $2007

    // PPU Memory Map
    let palette: [Byte] = [Byte](count: 0x20, repeatedValue: 0)
    let nameTables: [Byte] = [Byte](count: 0x1000, repeatedValue: 0)

    //---------------------------------------- $4000
    // Empty
    //---------------------------------------- $3F20
    // Sprite Palette
    //---------------------------------------- $3F10
    // Image Palette
    //---------------------------------------- $3F00
    // Empty
    //---------------------------------------- $3000
    // Attribute Table 3
    //---------------------------------------- $2FC0
    // Name Table 3 (32x30 tiles)
    //---------------------------------------- $2C00
    // Attribute Table 2
    //---------------------------------------- $2BC0
    // Name Table 2 (32x30 tiles)
    //---------------------------------------- $2800
    // Attribute Table 1
    //---------------------------------------- $27C0
    // Name Table 1 (32x30 tiles)
    //---------------------------------------- $2400
    // Attribute Table 0
    //---------------------------------------- $23C0
    // Name Table 0 (32x30 tiles)
    //---------------------------------------- $2000
    // Pattern Table 1 (256x2x8, may be VROM)
    //---------------------------------------- $1000
    // Pattern Table 0 (256x2x8, may be VROM)
    //---------------------------------------- $0000

}
