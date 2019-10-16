//
//  NSFPrioritizedDelegateContainerSpec.swift
//  NSFKit
//
//  Created by shlexingyu on 2018/11/12.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class NSFPrioritizedDelegateContainerSpec: QuickSpec {
    
    override func spec() {
        
        describe("When input delegates directly") {
            context("with weak reference") {
                it("Should be nil after outside strong ref being nil") {
                    var container: NSFPrioritizedDelegateContainer?

                    let result = weaklyScoped(NSObject()) {
                        container = NSFPrioritizedDelegateContainer.init(delegates: [$0], weakRef: true)
                    }
                    // temporarily solution to avoid variable never warning
                    print(container!)

                    expect(result).to(beNil())
                }
            }

            context("with strong reference") {
                it("Should stay still after outside strong ref being nil") {
                    var container: NSFPrioritizedDelegateContainer?

                    let result = weaklyScoped(NSObject()) {
                        container = NSFPrioritizedDelegateContainer.init(delegates: [$0], weakRef: false)
                    }
                    print(container!)

                    expect(result).toNot(beNil())
                }
            }
        }
        
        describe("When input delegates wrapping in NSFPrioritizedDelegate") {
            context("with weak reference") {
                it("Should be nil after outside strong ref being nil") {
                    var container: NSFPrioritizedDelegateContainer?

                    let result = weaklyScoped(NSObject()) {
                        container = NSFPrioritizedDelegateContainer.init(prioritizedDelegate: [NSFPrioritizedDelegate.init(content: $0, weakRef: true)])
                    }
                    print(container!)

                    expect(result).to(beNil())
                }
            }

            context("with strong reference") {
                it("Should stay still after outside strong ref being nil") {
                    var container: NSFPrioritizedDelegateContainer?

                    let result = weaklyScoped(NSObject()) {
                        container = NSFPrioritizedDelegateContainer.init(prioritizedDelegate: [NSFPrioritizedDelegate.init(content: $0, weakRef: false)])
                    }
                    print(container!)

                    expect(result).toNot(beNil())
                }
            }
        }
    }
}
