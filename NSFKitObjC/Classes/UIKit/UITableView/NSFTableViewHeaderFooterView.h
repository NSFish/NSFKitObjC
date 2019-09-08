//
//  NSFTableViewHeaderFooterView.h
//  TQMall
//
//  Created by NSFish on 2018/10/24.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 修正 UITableViewHeaderFooterView 的各种 bug：
 - 移除 UITableViewHeaderFooterView 偶现的 Autolayout 警告
 - 设置 backgroundView = [UIView new]，以保证 backgroundView.backgroundColor 有效
 */
@interface NSFTableViewHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong, nullable, setter=nsf_setAccessoryView:) UIView *nsf_accessoryView;

/**
 设置此 block 会 enable NSFTableViewHeaderFooterView 自带的 UITapGestureRecognizer. 相应地设为 nil 则会 disable UITapGestureRecognizer.
 */
@property (nonatomic, copy, nullable) dispatch_block_t contentViewTapped;

/**
 UITableViewHeaderFooterView 会在 layoutSubviews 中修改 textLabelFont 的值导致外部设置无效
 这里提供一个 placeholder，在 layoutSubviews 中再进行设置
 */
@property (nonatomic, copy, nullable) UIFont *nsf_textLabelFont;
@property (nonatomic, copy, nullable) UIColor *nsf_textLabelColor;

/**
 用于强制指定 textLabel 的左偏移值，为 0 或小于 0 时不与使用。默认为 0。
 */
@property (nonatomic, assign) CGFloat textLabelX;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
