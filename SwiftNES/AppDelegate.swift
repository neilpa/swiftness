//
//  AppDelegate.swift
//  SwiftNES
//
//  Created by Neil Pankey on 7/15/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Cocoa

let width: UInt = 256
let height: UInt = 240
let pixels = width * height

struct RGB {
    var r: Byte
    var g: Byte
    var b: Byte
}

var screen = [RGB](count:Int(pixels), repeatedValue:RGB(r:255, g:0, b:0))

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow?
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let path = "/Users/neilpa/code/emu/nes/test/nestest.nes"
//        let path = "/Users/neilpa/code/emu/roms/Roms/VS/VS Super Mario Bros (VS).nes"
//        let path = "/Users/neilpa/code/emu/roms/Roms/VS/Soccer (VS).nes"
        let cart = Cartridge(path: path)
        
        // Dump the pattern tables
        
        var ppu = PPU()
        var cpu = CPU(memory: MemMap(cart: cart, ppu: ppu))
        //cpu.trace = true

        var count = 0
        while ++count < 100000 {
            // TODO Should return num cycles
            //print(String(format:"%05i", count++) + "  ")
            cpu.step()
        }
        
        ppu.raster(cart)
        
        for y in 0..<screenHeight {
            for x in 0..<screenWidth {
                let index = y * screenWidth + x;
                let color: Byte = ppu.screen[index].R != 0 ? 255 : 0;
                screen[index].r = color;
                screen[index].g = color;
                screen[index].b = color;
            }
        }
        
//        let context: CGContext? = window?.cgContext()
        let context: CGContext! = window?.cgContext()
        let data = NSData(bytes: screen, length: screen.count * sizeof(RGB))
        let provider = CGDataProviderCreateWithCFData(data)
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let info = CGBitmapInfo.ByteOrderDefault

        let image = CGImageCreate(width, height, 8, 24, 3 * width, colorspace, info, provider, nil, false, kCGRenderingIntentDefault);
        
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        CGContextSetShouldAntialias(context, false);
        CGContextScaleCTM(context, 2, 2);
        
        CGContextDrawImage(context, CGRect(x: 0, y: 0, width: 256, height: 240), image);
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

}

