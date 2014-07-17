//
//  GraphicsContext.h
//  Swiftness
//
//  Created by Neil Pankey on 7/17/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NSWindow (CGContext)
- (CGContextRef)cgContext NS_RETURNS_INNER_POINTER;
@end