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

+ (instancetype)embed:(UIViewController *)rootVC NS_SWIFT_NAME(embed(rootVC:));

- (void)nsf_popViewControllers:(NSInteger)number
                      animated:(BOOL)animated NS_SWIFT_NAME(pop(number:animated:));

/**
 替换当前的 VC，动画效果看起来和 Push 一样。目前已知的问题是
 1. 被替换的 VC 的 viewWillDisappear 方法中，获取到的 navigationController 是 nil
 2. 被替换的 VC 消失时，willMoveToParentViewController: 不会被调用
 
 @param vc 待显示的 VC
 */
- (void)nsf_replaceCurrentVCWith:(UIViewController *)vc
                        animated:(BOOL)animated NS_SWIFT_NAME(replaceCurrentVC(with:animated:));

@end

NS_ASSUME_NONNULL_END
