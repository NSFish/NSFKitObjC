//
//  UIColor+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import "UIColor+NSFExt.h"

@implementation UIColor (NSFExt)

+ (instancetype)colorWithHex:(NSUInteger)hex
{
    return [self colorWithHex:hex alpha:1.0];
}

+ (instancetype)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)nsf_gradientColorWithColors:(NSArray<UIColor *> *)colors
                                  frame:(CGRect)frame
                            orientation:(NSFGradientColorOrientation)orientation
{
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = frame;
    
    NSMutableArray *cgColors = [NSMutableArray new];
    [colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger idx, BOOL *stop) {
        [cgColors addObject:(id)color.CGColor];
    }];
    gradientLayer.colors = cgColors;
    
    switch (orientation) {
        case NSFGradientColorOrientationHorizontal:
        {
            gradientLayer.startPoint = CGPointMake(0, .5);
            gradientLayer.endPoint = CGPointMake(1, .5);
        }
            break;
        case NSFGradientColorOrientationVertical:
        {
            // startPoint 默认值为 [.5,0], endPoint 默认值为 [.5,1]
            // 即默认情况下就是垂直渲染的，无须调整
        }
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

#ifdef DEBUG
+ (UIColor *)nsf_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
#endif

@end
