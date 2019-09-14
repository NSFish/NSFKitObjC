//
//  UIViewControllerSepc.swift
//  NSFKit
//
//  Created by shlexingyu on 2018/11/8.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class UIViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            if let _ = UIViewController.rootVC?.presentedViewController {
                waitUntil { done in
                    UIViewController.rootVC?.dismiss(animated: false) { done() }
                }
            }
            
            UIViewController.rootVC = nil
        }
        
        describe("NSFContainerViewControllerProtocol") {
            context("Implemented by NSFContainerViewController") {
                it("Should return currentContentVC as currentVC") {
                    let vc = UIViewController()
                    let containerVC = NSFContainerViewController.init()
                    containerVC.setContentViewControllers([vc])
                    
                    expect(containerVC.currentContentVC).to(equal(vc))
                }
            }
            
            context("Implemented by UINavigationController") {
                it("Should return topVC as currentVC") {
                    let naviVC = UINavigationController.init(rootViewController: UIViewController())
                    
                    expect(naviVC.currentContentVC).to(equal(naviVC.topViewController))
                }
            }
            
            context("Implemented by UITabBarController") {
                it("Should return selectedVC as currentVC") {
                    let tabVC = UITabBarController.init()
                    tabVC.viewControllers = [UIViewController()]
                    
                    expect(tabVC.currentContentVC).to(equal(tabVC.selectedViewController))
                }
            }
        }
        
        describe("Getting presented VC") {
            context("When not presenting any VC") {
                it("Should return nil") {
                    expect(UIViewController.currentPresentedVC()).to(beNil())
                }
            }
            
            context("When presenting UIViewController") {
                it("Should return UIViewController") {
                    let vcToPresent = UIViewController()
                    UIViewController.rootVC?.present(vcToPresent, animated: false, completion: nil)
                    
                    expect(UIViewController.currentPresentedVC()).toEventually(equal(vcToPresent))
                }
            }
            
            context("When using UINavigationController - UIViewController structure") {
                it("Should return UIViewController") {
                    let vc = UIViewController()
                    let naviVC = UINavigationController.embed(rootVC: vc)
                    
                    UIViewController.rootVC?.present(naviVC, animated: false, completion: nil)
                    
                    expect(UIViewController.currentPresentedVC()).toEventually(equal(vc))
                }
            }
            
            context("When presenting multiple UIViewController") {
                it("Should return nextVCToPresent") {
                    let vcToPresent = UIViewController()
                    UIViewController.rootVC?.present(vcToPresent, animated: false, completion: nil)
                    let nextVCToPresent = UIViewController()
                    vcToPresent.present(nextVCToPresent, animated: false, completion: nil)
                    
                    expect(UIViewController.currentPresentedVC()).toEventually(equal(nextVCToPresent))
                }
            }
            
            context("When using Custom Container") {
                context("Without any child VC") {
                    it("Should return containerVC itself") {
                        let containerVC = NSFContainerViewController()
                        UIViewController.rootVC?.present(containerVC, animated: false, completion: nil)
                        
                        expect(UIViewController.currentPresentedVC()).toEventually(equal(containerVC))
                    }
                }
            }
        }
        
        describe("Getting current visiable VC") {
            context("Not counting presented VC") {
                context("When using UINavigationController - UIViewController structure") {
                    context("with one child") {
                        it("Should return topVC") {
                            let naviVC = UINavigationController.init(rootViewController: UIViewController())
                            UIViewController.rootVC = naviVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(naviVC.topViewController))
                        }
                    }
                    
                    context("with multiple children") {
                        it("Should return topVC") {
                            let naviVC = UINavigationController.init(rootViewController: UIViewController())
                            naviVC.pushViewController(UIViewController(), animated: false)
                            UIViewController.rootVC = naviVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(naviVC.topViewController))
                        }
                    }
                }
                
                context("When using UITabBarController - UIViewController structure") {
                    context("with one child") {
                        it("Should return tabVC's selectedVC") {
                            let tabVC = UITabBarController.init()
                            tabVC.viewControllers = [UIViewController()]
                            UIViewController.rootVC = tabVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(tabVC.selectedViewController))
                        }
                    }
                    
                    context("with multiple children") {
                        it("Should return tabVC's selectedVC") {
                            let tabVC = UITabBarController.init()
                            tabVC.viewControllers = [UIViewController(), UIViewController()]
                            UIViewController.rootVC = tabVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(tabVC.selectedViewController))
                        }
                    }
                }
                
                context("When using UITabBarController - UINaivigationController - UIViewController structure") {
                    context("with one child") {
                        it("Should return tabVC's selectedVC's topVC") {
                            let tabVC = UITabBarController.init()
                            let naviVC = UINavigationController.embed(rootVC: UIViewController())
                            tabVC.viewControllers = [naviVC]
                            UIViewController.rootVC = tabVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(naviVC.topViewController))
                        }
                    }
                    
                    context("with multiple children") {
                        it("Should return tabVC's selectedVC's topVC") {
                            let tabVC = UITabBarController.init()
                            let naviVCs = [UINavigationController.embed(rootVC: UIViewController()),
                                           UINavigationController.embed(rootVC: UIViewController())]
                            tabVC.viewControllers = naviVCs
                            UIViewController.rootVC = tabVC
                            
                            let naviVC = naviVCs[tabVC.selectedIndex]
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(naviVC.topViewController))
                        }
                    }
                }
                
                context("When using NSFContainerVC - UIViewController structure") {
                    context("with one child") {
                        it("Should return NSFContainerVC's currentContentVC") {
                            let containerVC = NSFContainerViewController.init()
                            containerVC.addContentViewController(UIViewController(), autolayoutConfig: nil)
                            UIViewController.rootVC = containerVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(containerVC.currentContentVC))
                        }
                    }
                    
                    context("with multiple children") {
                        it("Should return NSFContainerVC's currentContentVC") {
                            let containerVC = NSFContainerViewController.init()
                            containerVC.setContentViewControllers([UIViewController(),
                                                                   UIViewController()])
                            containerVC.setCurrentContentVC(containerVC.children.last, animated: false)
                            UIViewController.rootVC = containerVC
                            
                            expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(containerVC.currentContentVC))
                        }
                    }
                }
                
                context("When using UINavigationController - NSFContainerVC - UIViewController structure") {
                    it("Should return NSFContainerVC's currentContentVC") {
                        let containerVC = NSFContainerViewController.init()
                        containerVC.addContentViewController(UIViewController(), autolayoutConfig: nil)
                        UIViewController.rootVC = UINavigationController.embed(rootVC: containerVC)
                        
                        expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(containerVC.currentContentVC))
                    }
                }
                
                context("When using UITabBarController - UINavigationController - NSFContainerViewController - UIViewController structure") {
                    it("Should return NSFContainerVC's currentContentVC") {
                        let vc = UIViewController()
                        let containerVC = NSFContainerViewController.init()
                        containerVC.addContentViewController(vc, autolayoutConfig: nil)
                        let naviVC = UINavigationController.init(rootViewController: containerVC)
                        let tabVC = UITabBarController.init()
                        tabVC.viewControllers = [naviVC]
                        
                        UIViewController.rootVC = tabVC
                        
                        expect(UIViewController.currentVisibleVCCountingPresent(false)).to(be(vc))
                    }
                }
            }
            
            context("Counting presented VC") {
                let naviVC = UINavigationController.embed(rootVC: UIViewController())
                UIViewController.rootVC?.present(naviVC, animated: false, completion: nil)
                
                expect(UIViewController.currentVisibleVC()).toEventually(equal(UIViewController.currentPresentedVC()))
            }
        }
    }
}
