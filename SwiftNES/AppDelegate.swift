//
//  AppDelegate.swift
//  SwiftNES
//
//  Created by Neil Pankey on 7/15/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Cocoa

let width: Int = 256
let height: Int = 240
let pixels = width * height

struct RGB {
    var r: Byte
    var g: Byte
    var b: Byte
}


struct Plane {
    private let pixels: ArraySlice<Byte>;

    init (_ pixels: ArraySlice<Byte>) {
        assert(pixels.count == 8)
        self.pixels = pixels;
    }
    
    func pixel(x: Int, _ y: Int) -> Byte {
        return (pixels[y] >> Byte(x)) & 1
    }
}

// 8x8 grid of pixesl at 2BPP
struct Tile {
    private let plane0: Plane
    private let plane1: Plane

    init (pixels: ArraySlice<Byte>) {
        assert(pixels.count == 16)
        plane0 = Plane(prefix(pixels, 8))
        plane1 = Plane(suffix(pixels, 8))
    }
    
    func pixel(x: Int, _ y: Int) -> Byte {
        let b0 = plane0.pixel(x, y)
        let b1 = plane1.pixel(x, y)
        return Byte(b1 << 1) | b0
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        let path = "/Users/neilpa/code/emu/nes/test/nestest.nes"
        let path = "/Users/neilpa/code/emu/roms/Roms/VS/VS Super Mario Bros (VS).nes"
//        let path = "/Users/neilpa/code/emu/roms/Roms/VS/Soccer (VS).nes"
        let cart = Cartridge(path: path)
        
        var screen = [RGB](count:Int(pixels), repeatedValue:RGB(r:0, g:0, b:0))
        
//        var tiles: [Tile] = []
//        for i in 0..<960 {
//            let index = i * 16
//            let slice = cart.chrROM.data[index..<index+16]
//            tiles.append(Tile(pixels: slice))
//        }
//        
//        for y in 0..<240 {
//            for x in 0..<256 {
//                let tile = tiles[(y/8) * 32 + x/8]
//                let color = tile.pixel(x % 8, y % 8)
//                let index = y * 256 + x
//
//                switch color {
//                case 1: screen[index].r = 255
//                case 2: screen[index].g = 255
//                case 3: screen[index].b = 255
//                default: break
//                }
//            }
//        }
        
        var ppu = PPU()
        var cpu = CPU(memory: MemMap(cart: cart, ppu: ppu))

        var count = 0
        while ++count < 20000 {
            // TODO Should return num cycles
            //print(String(format:"%05i", count++) + "  ")
            cpu.step()
        }
        
        cpu.nmi()

        count = 0
        cpu.trace = true
        while ++count < 5000 {
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
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

