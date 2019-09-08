//
//  UILabel+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (NSFExt)
@property (nonatomic, assign, setter=nsf_setFontSize:) CGFloat nsf_fontSize;
@property (nonatomic, assign, setter=nsf_setBoldFontSize:) CGFloat nsf_boldFontSize;

- (void)nsf_setMediumWeightWithFontSize:(CGFloat)size;
- (void)nsf_setRegularWeightWithFontSize:(CGFloat)size;

/**
 设为 YES 则该 label 可长按复制. 默认为 NO
 */
@property (nonatomic, assign, setter=nsf_setCopyable:) BOOL nsf_copyable;

/**
 复制时的 action，默认为复制 text/attributedText 到剪贴板中
 */
@property (nonatomic, copy, nullable, setter=nsf_setCustomCopyAction:) dispatch_block_t nsf_customCopyAction;

@end

NS_ASSUME_NONNULL_END
