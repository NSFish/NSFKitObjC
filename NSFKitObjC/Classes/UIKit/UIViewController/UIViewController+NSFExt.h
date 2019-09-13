//
//  UIViewController+NSFExt.h
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFContainerViewController;

@interface UIViewController (NSFExt)
@property (nonatomic, assign) BOOL hideNavigationBar;

#pragma mark - Hierarchy
+ (nullable UIViewController *)currentPresentedVC;
+ (UIViewController *)currentVisibleVC;
+ (UIViewController *)currentVisibleVCCountingPresent:(BOOL)countingPresent;
- (BOOL)isTopVC;

- (nullable UIViewController<NSFContainerViewController> *)containerVC;

- (void)vanishIfPossible;
- (void)vanishIfPossible:(BOOL)animated;

#pragma mark - Unit Testing
@property (class, nonatomic, weak) UIViewController *rootVC;

@end

NS_ASSUME_NONNULL_END
