//
//  AppDelegate.swift
//  SwiftNES
//
//  Created by Neil Pankey on 7/15/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        window.contentView.addSubview(nil)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}
