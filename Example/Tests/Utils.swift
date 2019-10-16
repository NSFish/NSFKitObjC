//
//  Utils.swift
//  NSFKitObjC_Tests
//
//  Created by nsfish on 2019/10/16.
//  Copyright © 2019 NSFish. All rights reserved.
//

import Foundation

// https://medium.com/@londeix/swift-weak-reference-assertion-cf04fef6c334
func weaklyScoped<T: AnyObject>(_ v: @autoclosure () -> T, action: (T) throws -> ()) rethrows -> T? {
    weak var weakValue: T?
    do { // optionally autoreleasepool
        let value = v()
        try action(value)
        weakValue = value
    }
    
    return weakValue
}
