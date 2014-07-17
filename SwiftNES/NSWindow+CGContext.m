//
//  GraphicsContext.m
//  Swiftness
//
//  Created by Neil Pankey on 7/17/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

#import "NSWindow+CGContext.h"

@implementation NSWindow (CGContext)

- (CGContextRef)cgContext {
    return self.graphicsContext.graphicsPort;
}

@end