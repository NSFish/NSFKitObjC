//
//  UITableView+NSFExt.h
//  TQMall
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFReusableUIComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (NSFExt)

/**
 注册 cell，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerCell:(Class)cellClass;

/**
 注册 headerFooterView，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerSectionHeaderFooterView:(Class)viewClass;

/**
 用 UIImage 来指定分割线显示效果，比如渐变色图片、虚线等，不能与 setSeparatorColor 共用
 */
- (void)nsf_setSeparatorImage:(UIImage *)image;

/**
 设置分割线为虚线
 */
- (void)nsf_setSeparatorStyleDashLine:(UIColor *)color;

/**
 从 iOS 11 起，UITableView 默认会使用 estimated heights, 这会使 UITableView 的 contentSize 值不可靠(即使在 layoutSubviews 之后也是如此). 如展开、收起 section 这样依赖于 contentSize 的代码就会失效. 这里提供一个关闭的 wrapper, 方式是将 UITableView 的 estimatedRowHeight、estimatedSectionHeaderHeight 和 estimatedSectionFooterHeight 设置为 0.
 Ref: https://forums.developer.apple.com/thread/81895
 */
- (void)nsf_disableEstimatedHeight;

- (void)nsf_performBatchUpdates:(nullable void(NS_NOESCAPE^)(void))updates
                    completion:(nullable void(^)(BOOL finished))completion;

/**
 移除 Gourped Style tableView 顶部的留白
 */
- (void)nsf_removeTopPadding4GroupedTableView;

/**
 移除 Gourped Style tableView 底部高度为 20 的空白【在 tableFooterView 下方】
 */
- (void)nsf_removeBottomPadding4GroupedTableView;

@end

NS_ASSUME_NONNULL_END
