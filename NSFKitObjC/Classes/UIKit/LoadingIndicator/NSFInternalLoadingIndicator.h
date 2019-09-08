//
//  NSFInternalLoadingIndicator.h
//  TQMall
//
//  Created by Jamin on 13/9/18.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <NSFLoadingIndicatorProtocol.h>
#import "NSFLoadingIndicatorContentViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFInternalLoadingIndicator : UIView<NSFLoadingIndicator>

- (instancetype)initWithLoadingView:(__kindof UIView<NSFLoadingIndicatorContentView> *)contentView NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
