//
//  Palette.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/16/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

struct ColorRGB {
    var R: Byte
    var G: Byte
    var B: Byte

    init(_ r: Byte, _ g: Byte, _ b: Byte) {
        R = r
        G = g
        B = b
    }
}

// Approximate RBG palette adapted from page source here
// http://www.dev.bowdenweb.com/nes/nes-color-palette.html

let palette = [
    ColorRGB(124,124,124),
    ColorRGB(0,0,252),
    ColorRGB(0,0,188),
    ColorRGB(68,40,188),
    ColorRGB(148,0,132),
    ColorRGB(168,0,32),
    ColorRGB(168,16,0),
    ColorRGB(136,20,0),
    ColorRGB(80,48,0),
    ColorRGB(0,120,0),
    ColorRGB(0,104,0),
    ColorRGB(0,88,0),
    ColorRGB(0,64,88),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
    ColorRGB(188,188,188),
    ColorRGB(0,120,248),
    ColorRGB(0,88,248),
    ColorRGB(104,68,252),
    ColorRGB(216,0,204),
    ColorRGB(228,0,88),
    ColorRGB(248,56,0),
    ColorRGB(228,92,16),
    ColorRGB(172,124,0),
    ColorRGB(0,184,0),
    ColorRGB(0,168,0),
    ColorRGB(0,168,68),
    ColorRGB(0,136,136),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
    ColorRGB(248,248,248),
    ColorRGB(60,188,252),
    ColorRGB(104,136,252),
    ColorRGB(152,120,248),
    ColorRGB(248,120,248),
    ColorRGB(248,88,152),
    ColorRGB(248,120,88),
    ColorRGB(252,160,68),
    ColorRGB(248,184,0),
    ColorRGB(184,248,24),
    ColorRGB(88,216,84),
    ColorRGB(88,248,152),
    ColorRGB(0,232,216),
    ColorRGB(120,120,120),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
    ColorRGB(252,252,252),
    ColorRGB(164,228,252),
    ColorRGB(184,184,248),
    ColorRGB(216,184,248),
    ColorRGB(248,184,248),
    ColorRGB(248,164,192),
    ColorRGB(240,208,176),
    ColorRGB(252,224,168),
    ColorRGB(248,216,120),
    ColorRGB(216,248,120),
    ColorRGB(184,248,184),
    ColorRGB(184,248,216),
    ColorRGB(0,252,252),
    ColorRGB(216,216,216),
    ColorRGB(0,0,0),
    ColorRGB(0,0,0),
]

