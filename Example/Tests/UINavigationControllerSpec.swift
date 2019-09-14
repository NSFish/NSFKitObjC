//
//  UINavigationControllerSpec.swift
//  NSFKitObjC_Tests
//
//  Created by nsfish on 2019/9/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class UINavigationControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Embed vc") {
            it("should return that vc as topVC") {
                let vc = UIViewController()
                let naviVC = UINavigationController.embed(rootVC: vc)
                
                expect(naviVC.topViewController).to(equal(vc))
            }
        }
        
        describe("Pop vc") {
            context("when number smaller than 0") {
                it("nothing happened") {
                    let naviVC = UINavigationController()
                    let vcCount = 5
                    for _ in 1...vcCount {
                        naviVC.pushViewController(UIViewController(), animated: false)
                    }
                    
                    naviVC.pop(number: -1, animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(vcCount))
                }
            }
            
            context("when number equals to 0") {
                it("nothing happened") {
                    let naviVC = UINavigationController()
                    let vcCount = 5
                    for _ in 1...vcCount {
                        naviVC.pushViewController(UIViewController(), animated: false)
                    }
                    
                    naviVC.pop(number: 0, animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(vcCount))
                }
            }
            
            context("when number equals to the current childVC count") {
                it("nothing happened") {
                    let naviVC = UINavigationController()
                    let vcCount = 5
                    for _ in 1...vcCount {
                        naviVC.pushViewController(UIViewController(), animated: false)
                    }
                    
                    naviVC.pop(number: vcCount, animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(vcCount))
                }
            }
            
            context("when number bigger than the current childVC count") {
                it("nothing happened") {
                    let naviVC = UINavigationController()
                    let vcCount = 5
                    for _ in 1...vcCount {
                        naviVC.pushViewController(UIViewController(), animated: false)
                    }
                    
                    naviVC.pop(number: vcCount + 1, animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(vcCount))
                }
            }
            
            context("when number is appropriate") {
                it("should pop back to the last remaining vc") {
                    let naviVC = UINavigationController()
                    let vcCount = 5
                    for index in 1...vcCount {
                        let vc = UIViewController()
                        vc.title = String(index - 1)
                        naviVC.pushViewController(vc, animated: false)
                    }
                    
                    let number = 3
                    let lastRemainIndex = vcCount - number - 1
                    naviVC.pop(number: number, animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(vcCount - number))
                    expect(naviVC.topViewController?.title).to(equal(String(lastRemainIndex)))
                }
            }
        }
        
        describe("Replace topVC") {
            context("When naviVC has no childVCs") {
                it("Nothing happened") {
                    let naviVC = UINavigationController()
                    
                    naviVC.replaceCurrentVC(with: UIViewController(), animated: false)
                    
                    expect(naviVC.viewControllers.count).to(equal(0))
                }
            }
            
            context("When naviVC has childVCs") {
                context("With UITabBarController instance") {
                    it("Nothing happened") {
                        let vc = UITabBarController()
                        let naviVC = UINavigationController.init(rootViewController: UIViewController())
                        let topVC = naviVC.topViewController!
                        
                        naviVC.replaceCurrentVC(with: vc, animated: false)
                        
                        expect(naviVC.topViewController).to(equal(topVC))
                    }
                }
                
                context("With UINavigationController instance") {
                    it("Nothing happened") {
                        let vc = UINavigationController()
                        let naviVC = UINavigationController.init(rootViewController: UIViewController())
                        let topVC = naviVC.topViewController!
                        
                        naviVC.replaceCurrentVC(with: vc, animated: false)
                        
                        expect(naviVC.topViewController).to(equal(topVC))
                    }
                }
                
                context("With vc already in stack") {
                    it("Nothing happened") {
                        let vc = UIViewController()
                        let naviVC = UINavigationController.init(rootViewController:vc)
                        let topVC = UIViewController()
                        naviVC.pushViewController(topVC, animated: false)
                        
                        naviVC.replaceCurrentVC(with: vc, animated: false)
                        
                        expect(naviVC.topViewController!).to(equal(topVC))
                    }
                }
                
                context("With current topVC") {
                    it("Nothing happened") {
                        let topVC = UIViewController()
                        let naviVC = UINavigationController.init(rootViewController:topVC)
                        
                        naviVC.replaceCurrentVC(with: topVC, animated: false)
                        
                        expect(naviVC.topViewController!).to(equal(topVC))
                    }
                }
                
                context("With new VC") {
                    it("should replace current topVC with it") {
                        let oldVC = UIViewController()
                        let naviVC = UINavigationController.init(rootViewController:oldVC)
                        let newVC = UIViewController()
                        
                        naviVC.replaceCurrentVC(with: newVC, animated: false)
                        
                        expect(naviVC.topViewController!).to(equal(newVC))
                    }
                }
            }
        }
    }
}

