//
//  Overflow.swift
//  Swiftness
//
//  Created by Neil Pankey on 7/11/14.
//  Copyright (c) 2014 Neil Pankey. All rights reserved.
//

protocol Overflowable {
    class func addWithOverflow(lhs: Self, _ rhs: Self) -> (Self, overflow: Bool)
    class func subtractWithOverflow(lhs: Self, _ rhs: Self) -> (Self, overflow: Bool)
}

// Only extending the types currently used
extension Int8 : Overflowable {}
extension UInt8 : Overflowable {}
extension UInt16 : Overflowable {}

// Addition that ignores overflow
operator infix +! {}
@infix func +!<T: Overflowable> (lhs: T, rhs: T) -> T {
    let (sum, _) = T.addWithOverflow(lhs, rhs)
    return sum
}

// Subtraction that ignores overflow
operator infix -! {}
@infix func -!<T: Overflowable> (lhs: T, rhs: T) -> T {
    let (diff, _) = T.subtractWithOverflow(lhs, rhs)
    return diff
}
