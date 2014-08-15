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
        
        for y in 0...20 {
            for x in 0..<256 {
                screen[y*256 + x].r = 0
                screen[y*256 + x].g = 255
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

