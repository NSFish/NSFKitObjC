//
//  NSFCollectionViewDelegateProxySpec.swift
//  NSFKit
//
//  Created by shlexingyu on 2018/11/16.
//  Copyright © 2018年 NSFish. All rights reserved.
//

import Quick
import Nimble
import NSFKitObjC

class NSFCollectionViewDelegateProxySpec: QuickSpec {
    
    override func spec() {

        describe("VC and VM won't be retained") {
            it("Should be nil after strong ref being nil") {
                var vc: TestCollectionViewController? = TestCollectionViewController()
                var vm: TestCollectionViewModel? = TestCollectionViewModel()
                _ = NSFCollectionViewDelegateProxy.init(viewController: vc!, viewModel: vm!)
                vc = nil
                vm = nil
                
                expect(vc).to(beNil())
                expect(vm).to(beNil())
            }
        }
        
        describe("VC will always responde to cellForItemAtIndexPath:") {
            it("Dispite VM implements it or not") {
                let vc = TestCollectionViewController()
                let vm = TestCollectionViewModel()
                let proxy = NSFCollectionViewDelegateProxy.init(viewController: vc, viewModel: vm)
                proxy.collectionView(UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
                                     cellForItemAt: IndexPath.init(row: 0, section: 0))
                
                expect(vc.cellForItemAtIndexPathCalled).to(beTrue())
                expect(vm.cellForItemAtIndexPathCalled).to(beFalse())
            }
        }
        
        describe("VC will always responde to viewForSupplementaryElementOfKind: atIndexPath:") {
            it("Dispite VM implements it or not") {
                let vc = TestCollectionViewController()
                let vm = TestCollectionViewModel()
                let proxy = NSFCollectionViewDelegateProxy.init(viewController: vc, viewModel: vm)
                proxy.collectionView(UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()), viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init())
                
                expect(vc.viewForSupplementaryElementOfKindAtIndexPathCalled).to(beTrue())
                expect(vm.viewForSupplementaryElementOfKindAtIndexPathCalled).to(beFalse())
            }
        }
        
        describe("VC will always responde to didSelectItemAtIndexPath:") {
            it("Dispite VM implements it or not") {
                let vc = TestCollectionViewController()
                let vm = TestCollectionViewModel()
                let proxy = NSFCollectionViewDelegateProxy.init(viewController: vc, viewModel: vm)
                proxy.collectionView(UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
                                     didSelectItemAt: IndexPath.init(row: 0, section: 0))
                
                expect(vc.didSelectItemAtIndexPathCalled).to(beTrue())
                expect(vm.didSelectItemAtIndexPathCalled).to(beFalse())
            }
        }
    }
}

class TestCollectionViewController: UIViewController, NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate {
    
    var cellForItemAtIndexPathCalled = false
    var viewForSupplementaryElementOfKindAtIndexPathCalled = false
    var didSelectItemAtIndexPathCalled = false
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAtIndexPathCalled = true
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        viewForSupplementaryElementOfKindAtIndexPathCalled = true
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtIndexPathCalled = true
    }
}

class TestCollectionViewModel: NSObject, NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate {
    
    var cellForItemAtIndexPathCalled = false
    var viewForSupplementaryElementOfKindAtIndexPathCalled = false
    var didSelectItemAtIndexPathCalled = false
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAtIndexPathCalled = true
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        viewForSupplementaryElementOfKindAtIndexPathCalled = true
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtIndexPathCalled = true
    }
}

