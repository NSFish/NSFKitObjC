//
//  NSFPrioritizedDelegateSpec.swift
//  NSFKit
//
//  Created by shlexingyu on 2018/11/12.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class NSFPrioritizedDelegateSpec: QuickSpec {
    
    override func spec() {
        
        describe("Delegate captured won't be retained") {
            it("Should be nil after strong ref being nil") {
                var delegate: NSObject? = NSObject.init()
                _ = NSFPrioritizedDelegate.init(delegates: [delegate!], weakRef: true)
                delegate = nil
                
                expect(delegate).to(beNil())
            }
        }
    }
}
