//
//  UINavigationController+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UINavigationController+NSFExt.h"

@implementation UINavigationController (NSFExt)

+ (instancetype)embed:(UIViewController *)rootVC
{
    return [[self alloc] initWithRootViewController:rootVC];
}

- (void)nsf_popViewControllers:(NSInteger)number
                      animated:(BOOL)animated
{
    if (number <= 0
        || number >= self.viewControllers.count)
    {
        return;
    }
    
    UIViewController *vc = self.viewControllers[self.viewControllers.count - number - 1];
    [self popToViewController:vc animated:animated];
}

- (void)nsf_replaceCurrentVCWith:(UIViewController *)vc
                        animated:(BOOL)animated
{
    if (self.viewControllers.count == 0)
    {
        return;
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]
        || [vc isKindOfClass:[UINavigationController class]])
    {
        return;
    }
    
    if ([self.viewControllers containsObject:vc])
    {
        return;
    }
    
    if ([self.topViewController isEqual:vc])
    {
        return;
    }
    
    vc.hidesBottomBarWhenPushed = self.viewControllers.lastObject.hidesBottomBarWhenPushed;
    
    NSMutableArray<UIViewController *> *childVCs = [self.viewControllers mutableCopy];
    [childVCs removeLastObject];
    [childVCs addObject:vc];
    [self setViewControllers:childVCs animated:animated];
}

#pragma mark - NSFContainerViewController
- (UIViewController *)currentContentVC
{
    return self.topViewController;
}

- (void)setContentViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    self.viewControllers = viewControllers;
}

@end
