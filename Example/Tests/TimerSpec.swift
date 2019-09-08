//
//  TimerSpec.swift
//  NSFKit
//
//  Created by NSFish on 2018/11/1.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC
import Foundation

class TimerSpec: QuickSpec {
    override func spec() {
        
        let timeInterval = 0.01
        beforeSuite {
            AsyncDefaults.Timeout = 5
        }
        
        describe ("Create timer") {
            context ("With block-based API") {
                it ("Should not return nil") {
                    let timer = Timer.init(timeInterval: timeInterval,
                                           block: { _ in },
                                           userInfo: nil,
                                           repeatUntil: nil,
                                           finally: nil)
                    
                    expect(timer).toNot(beNil())
                }
            }
            
            context ("With target-selector API") {
                it ("Should not return nil") {
                    let timer = Timer.init(timeInterval: timeInterval,
                                           target: self,
                                           selector: #selector(TimerSpec.dummyTimerCallback(timer:)),
                                           userInfo: nil,
                                           repeatUntil: nil,
                                           finally: nil)
                    
                    expect(timer).toNot(beNil())
                }
            }
        }
        
        describe ("Schedule timer") {
            context ("With block-based API") {
                context ("When not repeating") {
                    it ("Timer should be invalid afterward") {
                        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                         block: { _ in },
                                                         userInfo: nil,
                                                         repeatUntil: nil,
                                                         finally: nil)
                        
                        expect(timer.isValid).toEventually(beFalsy())
                    }
                    
                    it ("Should call block only once") {
                        var count = 0
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             block: { _ in count += 1 },
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: nil)
                        
                        expect(count).toEventually(equal(1))
                    }
                }
                
                context ("When repeating") {
                    it ("Should keep calling block until meet condition") {
                        var count = 0
                        let repeatTimes = 3
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             block: { _ in count += 1 },
                                             userInfo: nil,
                                             repeatUntil: { return count > repeatTimes },
                                             finally: nil)
                        
                        expect(count).toEventually(beGreaterThan(repeatTimes))
                    }
                    
                    it ("Timer should be invalid afterward") {
                        var count = 0
                        var timer: Timer!
                        
                        waitUntil { done in
                            timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                         block: { _ in count += 1 },
                                                         userInfo: nil,
                                                         repeatUntil: { () -> Bool in
                                                            let meetCondition = count > 3
                                                            if meetCondition {
                                                                done()
                                                            }
                                                            
                                                            return meetCondition
                            },
                                                         finally: nil)
                        }
                        
                        expect(timer.isValid).to(beFalse())
                    }
                }
            }
            
            context("With target-selector API") {
                context ("When not repeating") {
                    it ("Target won't be retained") {
                        var target: DummyTimerTarget? = DummyTimerTarget.init()
                        weak var weakTarget = target
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: target!,
                                             selector: #selector(TimerSpec.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: nil)
                        
                        target = nil
                        
                        expect(weakTarget).to(beNil())
                    }
                    
                    it ("Timer should be invalid afterward") {
                        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                         target: self,
                                                         selector: #selector(TimerSpec.dummyTimerCallback(timer:)),
                                                         userInfo: nil,
                                                         repeatUntil: nil,
                                                         finally: nil)
                        
                        expect(timer.isValid).toEventually(beFalsy())
                    }
                    
                    it ("Should call selector only once") {
                        let target = DummyTimerTarget.init()
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: target,
                                             selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: nil)
                        
                        expect(target.count).toEventually(equal(1))
                    }
                }
                
                context ("When repeating") {
                    it ("Target won't be retained") {
                        var target: DummyTimerTarget? = DummyTimerTarget.init()
                        weak var weakTarget = target
                        
                        // Nimble 提供的 expectation 类本身会将传入的对象通过 @autoclosure 生成的 closure 强引用
                        // 要验证 weakTarget 是否为 nil 只能通过 XCTestExpectation 来做
                        let expectation = XCTestExpectation.init(description: "Target won't be retained")
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: target!,
                                             selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: { return false },
                                             finally: nil)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2 * timeInterval) {
                            target = nil
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4 * timeInterval, execute: {
                            XCTAssert(weakTarget == nil)
                            expectation.fulfill()
                        })
                        
                        self.wait(for: [expectation], timeout: AsyncDefaults.Timeout)
                    }
                    
                    it ("Should keep calling selector until meet condition") {
                        let target = DummyTimerTarget.init()
                        let repeatTimes = 3
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: target,
                                             selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: { [weak target] () -> Bool in
                                                return (target?.count ?? 100) > repeatTimes
                            },
                                             finally: nil)
                        
                        expect(target.count).toEventually(beGreaterThan(repeatTimes))
                    }
                    
                    it ("Timer should be invalid afterward") {
                        let target = DummyTimerTarget.init()
                        var timer: Timer!
                        
                        waitUntil { done in
                            timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                         target: target,
                                                         selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                                         userInfo: nil,
                                                         repeatUntil: { [weak target] () -> Bool in
                                                            let meetCondition = (target?.count ?? 100) >= 3
                                                            if meetCondition {
                                                                done()
                                                            }
                                                            
                                                            return meetCondition
                                },
                                                         finally: nil)
                        }
                        
                        expect(timer.isValid).to(beFalse())
                    }
                }
            }
        }
        
        describe ("Using finally") {
            context ("With block-based API") {
                context ("When not repeating") {
                    it ("finally block should be called") {
                        var finallyCalled = false
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             block: { _ in },
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: { finallyCalled = true })
                        
                        expect(finallyCalled).toEventually(beTrue())
                    }
                    
                    it ("Should call finally block only once") {
                        var finallyCount = 0
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             block: { _ in },
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: { finallyCount += 1 })
                        
                        expect(finallyCount).toEventually(equal(1))
                    }
                }
                
                context ("When repeating") {
                    context("to the end") {
                        it ("finally block should be called afterward") {
                            var finallyCalled = false
                            var count = 0
                            let repeatTimes = 3
                            
                            Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                 block: { _ in count += 1 },
                                                 userInfo: nil,
                                                 repeatUntil: { return count > repeatTimes },
                                                 finally: { finallyCalled = true })
                            
                            expect(finallyCalled).toEventually(beTrue())
                        }
                        
                        it ("Should call finally block only once") {
                            var finallyCount = 0
                            var count = 0
                            let repeatTimes = 3
                            
                            waitUntil { done in
                                Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                     block: { _ in count += 1 },
                                                     userInfo: nil,
                                                     repeatUntil: { () -> Bool in
                                                        let meetCondition = count > repeatTimes
                                                        if meetCondition {
                                                            done()
                                                        }
                                                        
                                                        return meetCondition
                                },
                                                     finally: { finallyCount += 1})
                            }
                            
                            expect(finallyCount).toEventually(equal(1))
                        }
                    }
                    
                    context("and invalidated manually") {
                        it ("finally block should be called afterward") {
                            var count = 0
                            var finallyCalled = false
                            let repeatTimes = 3
                            
                            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                             block: { _ in count += 1 },
                                                             userInfo: nil,
                                                             repeatUntil: { return count > repeatTimes },
                                                             finally: { finallyCalled = true })
                            timer.invalidate()
                            
                            expect(finallyCalled).to(beTrue())
                        }
                        
                        it ("Should call finally block only once") {
                            var count = 0
                            var finallyCount = 0
                            let repeatTimes = 3
                            
                            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                             block: { _ in count += 1 },
                                                             userInfo: nil,
                                                             repeatUntil: { return count > repeatTimes },
                                                             finally: { finallyCount += 1 })
                            timer.invalidate()
                            
                            expect(finallyCount).to(equal(1))
                        }
                    }
                }
            }
            
            context("With target-selector API") {
                context ("When not repeating") {
                    it ("finally block should be called") {
                        var finallyCalled = false
                        let target: DummyTimerTarget = DummyTimerTarget.init()
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: target,
                                             selector: #selector(TimerSpec.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: { finallyCalled = true})
                        
                        expect(finallyCalled).toEventually(beTrue())
                    }
                    
                    it ("Should call finally block only once") {
                        var finallyCount = 0
                        
                        Timer.scheduledTimer(withTimeInterval: timeInterval,
                                             target: self,
                                             selector: #selector(TimerSpec.dummyTimerCallback(timer:)),
                                             userInfo: nil,
                                             repeatUntil: nil,
                                             finally: { finallyCount += 1 })
                        
                        expect(finallyCount).toEventually(equal(1))
                    }
                }
                
                context ("When repeating") {
                    context("to the end") {
                        it ("finally block should be called afterward") {
                            var finallyCalled = false
                            let repeatTimes = 3
                            let target = DummyTimerTarget.init()
                            
                            Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                 target: target,
                                                 selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                                 userInfo: nil,
                                                 repeatUntil: { target.count > repeatTimes },
                                                 finally: { finallyCalled = true })
                            
                            expect(finallyCalled).toEventually(beTrue())
                        }
                        
                        it ("Should call finally block only once") {
                            var finallyCount = 0
                            let repeatTimes = 3
                            let target = DummyTimerTarget.init()
                            
                            Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                 target: target,
                                                 selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                                 userInfo: nil,
                                                 repeatUntil: { target.count > repeatTimes },
                                                 finally: { finallyCount += 1 })
                            
                            expect(finallyCount).toEventually(equal(1))
                        }
                    }
                    
                    context("and invalidated manually") {
                        it ("finally block should be called afterward") {
                            var finallyCalled = false
                            let repeatTimes = 3
                            let target = DummyTimerTarget.init()
                            
                            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                 target: target,
                                                 selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                                 userInfo: nil,
                                                 repeatUntil: { target.count > repeatTimes },
                                                 finally: { finallyCalled = true })
                            timer.invalidate()
                            
                            expect(finallyCalled).to(beTrue())
                        }
                        
                        it ("Should call finally block only once") {
                            var finallyCount = 0
                            let repeatTimes = 3
                            let target = DummyTimerTarget.init()
                            
                            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                                 target: target,
                                                 selector: #selector(DummyTimerTarget.dummyTimerCallback(timer:)),
                                                 userInfo: nil,
                                                 repeatUntil: { target.count > repeatTimes },
                                                 finally: { finallyCount += 1 })
                            timer.invalidate()
                            
                            expect(finallyCount).to(equal(1))
                        }
                    }
                }
            }
        }
    }
    
    @objc func dummyTimerCallback(timer: Timer) {}
}

class DummyTimerTarget : NSObject {
    
    var count = 0
    
    @objc func dummyTimerCallback(timer: Timer) {
        count += 1
    }
}
