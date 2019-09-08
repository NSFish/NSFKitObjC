//
//  UITabBarController+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/9.
//

#import "UITabBarController+NSFExt.h"

@implementation UITabBarController (NSFExt)

#pragma mark - NSFContainerViewController
- (UIViewController *)currentContentVC
{
    return self.selectedViewController;
}

- (void)setContentViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    self.viewControllers = viewControllers;
}

@end
