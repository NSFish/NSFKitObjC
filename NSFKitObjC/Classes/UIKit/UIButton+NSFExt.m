//
//  UIButton+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/12/21.
//

#import "UIButton+NSFExt.h"

@implementation NSFUIButtonBuilder
@end


@implementation UIButton (NSFExt)

+ (instancetype)nsf_customButton
{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (void)nsf_centerImageAndTitleVertincallyWithSpace:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0);
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2;
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0, edgeOffset, 0);
}

- (void)nsf_centerImageAndTitleHorizontallyWithSpace:(CGFloat)spacing
{
    CGFloat insetAmount = spacing / 2;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
}

- (void)nsf_setState:(UIControlState)state
withUIConfiguration:(void(NS_NOESCAPE ^)(NSFUIButtonBuilder *button))configuration
{
    NSFUIButtonBuilder *builder = [NSFUIButtonBuilder new];
    !configuration ?: configuration(builder);
    
    if (builder.title)
    {
        [self setTitle:builder.title forState:state];
    }
    if (builder.titleColor)
    {
        [self setTitleColor:builder.titleColor forState:state];
    }
    if (builder.titleShadowColor)
    {
        [self setTitleShadowColor:builder.titleShadowColor forState:state];
    }
    if (builder.attributedTitle)
    {
        [self setAttributedTitle:builder.attributedTitle forState:state];
    }
    if (builder.image)
    {
        [self setImage:builder.image forState:state];
    }
    if (builder.backgroundImage)
    {
        [self setBackgroundImage:builder.backgroundImage forState:state];
    }
}

@end
