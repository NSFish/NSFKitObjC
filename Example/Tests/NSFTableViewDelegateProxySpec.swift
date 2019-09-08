//
//  NSFTableViewDelegateProxySpec.swift
//  NSFKit
//
//  Created by shlexingyu on 2018/11/16.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class NSFTableViewDelegateProxySpec: QuickSpec {
    
    override func spec() {

        describe("VC and VM won't be retained") {
            it("Should be nil after strong ref being nil") {
                var vc: TestTableViewController? = TestTableViewController.init()
                var vm: TestTableViewModel? = TestTableViewModel.init()
                _ = NSFTableViewDelegateProxy.init(viewController: vc!, viewModel: vm!)
                vc = nil
                vm = nil
                
                expect(vc).to(beNil())
                expect(vm).to(beNil())
            }
        }
        
        describe("VC will always responde to cellForRowAtIndexPath:") {
            it("Dispite VM implements it or not") {
                let vc = TestTableViewController.init()
                let vm = TestTableViewModel.init()
                let proxy = NSFTableViewDelegateProxy.init(viewController: vc, viewModel: vm)
                proxy.tableView(UITableView.init(), cellForRowAt: IndexPath.init(row: 0, section: 0))
                
                expect(vc.cellForRowAtIndexPathCalled).to(beTrue())
                expect(vm.cellForRowAtIndexPathCalled).to(beFalse())
            }
        }
        
        describe("VC will always responde to didSelectRowAtIndexPath:") {
            it("Dispite VM implements it or not") {
                let vc = TestTableViewController.init()
                let vm = TestTableViewModel.init()
                let proxy = NSFTableViewDelegateProxy.init(viewController: vc, viewModel: vm)
                proxy.tableView(UITableView.init(), didSelectRowAt: IndexPath.init(row: 0, section: 0))
                
                expect(vc.didSelectRowAtIndexPathCalled).to(beTrue())
                expect(vm.didSelectRowAtIndexPathCalled).to(beFalse())
            }
        }
    }
}

class TestTableViewController: UIViewController, NSFAllOptionalTableViewDataSource, UITableViewDelegate {
    
    var cellForRowAtIndexPathCalled = false
    var didSelectRowAtIndexPathCalled = false
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRowAtIndexPathCalled = true
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPathCalled = true
    }
}

class TestTableViewModel: NSObject, NSFAllOptionalTableViewDataSource, UITableViewDelegate {
    
    var cellForRowAtIndexPathCalled = false
    var didSelectRowAtIndexPathCalled = false
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRowAtIndexPathCalled = true
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPathCalled = true
    }
}

