//
//  UIImage+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (NSFExt)

/**
 生成 {1, 1} 的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 生成指定大小的纯色图片，支持圆角
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius;

- (instancetype)scaleToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
