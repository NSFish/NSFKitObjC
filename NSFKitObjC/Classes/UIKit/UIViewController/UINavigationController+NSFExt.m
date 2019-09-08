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

- (void)nsf_popViewControllers:(NSUInteger)number animated:(BOOL)animated
{
    if (number == 0)
    {
        return;
    }
    else if (number >= self.viewControllers.count)
    {
        // do nothing
    }
    else
    {
        UIViewController *vc = self.viewControllers[self.viewControllers.count - number];
        [self popToViewController:vc animated:animated];
    }
}

- (void)nsf_replaceCurrentViewControllerWith:(UIViewController *)vc animated:(BOOL)animated
{
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

- (void)nsf_replaceLastSeveralViewControllers:(NSUInteger)number
                                        with:(UIViewController *)vc
                                    animated:(BOOL)animated
{
    if ([self.topViewController isEqual:vc])
    {
        return;
    }
    
    if (number == 0 || !vc)
    {
        return;
    }
    
    if ([self.viewControllers containsObject:vc])
    {
         NSUInteger index = [self.viewControllers indexOfObject:vc];
        if (index >= self.viewControllers.count - number)
        {
            [self popToViewController:vc animated:animated];
        }
        
        return;
    }
    
    vc.hidesBottomBarWhenPushed = self.viewControllers.lastObject.hidesBottomBarWhenPushed;
    
    NSMutableArray<UIViewController *> *childVCs = [self.viewControllers mutableCopy];
    [childVCs removeObjectsInRange:NSMakeRange(self.viewControllers.count - number, number)];
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
