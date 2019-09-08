//
//  UIColor+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a / 1.0]

typedef NS_ENUM(NSUInteger, NSFGradientColorOrientation)
{
    NSFGradientColorOrientationHorizontal,
    NSFGradientColorOrientationVertical
};

@interface UIColor (NSFExt)

+ (instancetype)colorWithHex:(NSUInteger)hex;
+ (instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

/**
 生成渐变色
 */
+ (UIColor *)nsf_gradientColorWithColors:(NSArray<UIColor *> *)colors
                                  frame:(CGRect)frame
                            orientation:(NSFGradientColorOrientation)orientation;

#ifdef DEBUG
/**
 随机颜色, debug only.
 */
+ (instancetype)nsf_randomColor;
#endif

@end

NS_ASSUME_NONNULL_END
