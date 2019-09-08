//
//  UINavigationController+NSFExt.h
//  TQMall
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSFContainerViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (NSFExt)<NSFContainerViewController>

+ (instancetype)embed:(UIViewController *)rootVC;

- (void)nsf_popViewControllers:(NSUInteger)number animated:(BOOL)animated;

/**
 替换当前的 VC，动画效果看起来和 Push 一样。目前已知的问题是
 1. 被替换的 VC 的 viewWillDisappear 方法中，获取到的 navigationController 是 nil
 2. 被替换的 VC 消失时，willMoveToParentViewController: 不会被调用

 @param vc 待显示的 VC
 */
- (void)nsf_replaceCurrentViewControllerWith:(UIViewController *)vc animated:(BOOL)animated;

- (void)nsf_replaceLastSeveralViewControllers:(NSUInteger)number
                                        with:(UIViewController *)vc
                                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
