//
//  UITextField+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (NSFExt)

/**
 调整光标的高度，若设置的值小于 0 或大于默认高度，则忽略
 */
@property (nonatomic, assign, setter=nsf_setCursorHeight:) CGFloat nsf_cursorHeight;

@end

NS_ASSUME_NONNULL_END
