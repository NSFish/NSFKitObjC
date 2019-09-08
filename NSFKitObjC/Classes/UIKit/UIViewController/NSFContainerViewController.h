
//
//  NSFContainerViewController.h
//  Cooloffice
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFBaseViewController.h"
#import "NSFContainerViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFContainerViewController : NSFBaseViewController<NSFContainerViewController>

#pragma mark - Add
- (void)addContentViewController:(UIViewController *)vc addToViewHierarchyAccordingly:(BOOL)addToViewHierarchyAccordingly;

/**
 *  添加 contentVC，同时自动将 contentVC.view 直接加入到 containerVC.view 中
 */
- (void)addContentViewController:(UIViewController *)vc
                autolayoutConfig:(nullable dispatch_block_t NS_NOESCAPE)autolayoutConfig;

/**
 *  添加 contentVC，可为 contentVC.view 指定一个 super view
 */
- (void)addContentViewController:(UIViewController *)vc
                       superView:(UIView *)superView
                autolayoutConfig:(nullable dispatch_block_t NS_NOESCAPE)autolayoutConfig;

#pragma mark - Remove
/**
 *  移除 contentVC，同时会移除 contentVC.view
 */
- (void)removeContentViewController:(UIViewController *)vc;

/**
 *  移除所有的 contentVC
 */
- (void)removeAllContentVCs;

@end

NS_ASSUME_NONNULL_END
