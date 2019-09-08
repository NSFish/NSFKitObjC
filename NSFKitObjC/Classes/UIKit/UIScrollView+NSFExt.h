//
//  UIScrollView+NSFExt.h
//  TQMall
//
//  Created by shlexingyu on 2019/3/14.
//  Copyright © 2019年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (NSFExt)
@property (readonly) NSUInteger currentPage;
@property (readonly) NSUInteger totalPage;

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated;

- (void)addNotLastPageView:(UIView *)view;
- (void)addLastPageView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
