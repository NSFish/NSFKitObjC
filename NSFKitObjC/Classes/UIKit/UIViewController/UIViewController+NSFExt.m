//
//  UIViewController+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UIViewController+NSFExt.h"
#import "NSObject+NSFExt.h"
#import "NSFContainerViewController.h"
#import "UINavigationController+NSFExt.h"
#import "UITabBarController+NSFExt.h"
#import "UIApplication+NSFExt.h"
#import <objc/runtime.h>

@implementation UIViewController (NSFExt)

- (BOOL)hideNavigationBar
{
    return objc_getAssociatedObject(self, @selector(hideNavigationBar));
}

- (void)setHideNavigationBar:(BOOL)hideNavigationBar
{
    objc_setAssociatedObject(self, @selector(hideNavigationBar), @(hideNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Hierarchy
+ (UIViewController *)currentPresentedVC
{
    UIViewController *presentedVC = self.rootVC;
    if (!presentedVC.presentedViewController)
    {
        return nil;
    }
    
    while (presentedVC.presentedViewController
           && !presentedVC.presentedViewController.isBeingDismissed)
    {
        presentedVC = presentedVC.presentedViewController;
    }
    
    UIViewController *vc = presentedVC;
    while ([vc conformsToProtocol:@protocol(NSFContainerViewController)]) {
        UIViewController<NSFContainerViewController> *containerVC = (UIViewController<NSFContainerViewController> *)vc;
        
        // 即使是容器 VC，也可能没有子 VC，此时将该容器 VC 返回即可
        // 如：http://chandao.yunpei.com/index.php?m=bug&f=view&bugID=51949
        if (containerVC.currentContentVC)
        {
            vc = containerVC.currentContentVC;
        }
        else
        {
            break;
        }
    }
    
    return vc;
}

+ (UIViewController *)currentVisibleVC
{
    return [self currentVisibleVCCountingPresent:YES];
}

+ (UIViewController *)currentVisibleVCCountingPresent:(BOOL)countingPresent
{
    if (countingPresent)
    {
        UIViewController *presentedVC = [self currentPresentedVC];
        if (presentedVC)
        {
            return presentedVC;
        }
    }
    
    UIViewController *vc = self.rootVC;
    while ([vc conformsToProtocol:@protocol(NSFContainerViewController)]) {
        UIViewController<NSFContainerViewController> *containerVC = (UIViewController<NSFContainerViewController> *)vc;
        
        // 即使是容器 VC，也可能没有子 VC，此时将该容器 VC 返回即可
        // 如：http://chandao.yunpei.com/index.php?m=bug&f=view&bugID=51949
        if (containerVC.currentContentVC)
        {
            vc = containerVC.currentContentVC;
        }
        else
        {
            break;
        }
    }
    
    return vc;
}

- (nullable UIViewController<NSFContainerViewController> *)containerVC
{
    if (!self.parentViewController
        || ![self.parentViewController conformsToProtocol:@protocol(NSFContainerViewController)])
    {
        return nil;
    }
    
    return (UIViewController<NSFContainerViewController> *)self.parentViewController;
}

#pragma mark - Unit Testing
+ (UIViewController *)rootVC
{
    UIViewController *vc = [self nsf_associatedObjectForKey:@selector(rootVC) policy:NSFObjcAssociationPolicyWeak];
    if (!vc)
    {
        return [[UIApplication sharedApplication] nsf_keyWindow].rootViewController;
    }
    
    return vc;
}

+ (void)setRootVC:(UIViewController *)rootVC
{
    [self nsf_setAssociatedObject:rootVC withKey:@selector(rootVC) policy:NSFObjcAssociationPolicyWeak];
}

@end
