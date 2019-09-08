//
//  UIButton+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFUIButtonBuilder : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) UIColor *titleShadowColor;
@property (nonatomic, copy) NSAttributedString *attributedTitle;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) UIImage *backgroundImage;

@end


@interface UIButton (NSFExt)

+ (instancetype)nsf_customButton NS_SWIFT_NAME(custom());

/**
 image 和 title 垂直居中显示，title 在 image 下方

 @param spacing 间距
 */
- (void)nsf_centerImageAndTitleVertincallyWithSpace:(CGFloat)spacing NS_SWIFT_NAME(centerImageAndTitleVertincally(withSpace:));

/**
 image 和 title 水平居中显示，image 在 title 左侧

 @param spacing 间距
 */
- (void)nsf_centerImageAndTitleHorizontallyWithSpace:(CGFloat)spacing NS_SWIFT_NAME(centerImageAndTitleHorizontally(withSpace:));

- (void)nsf_setState:(UIControlState)state
withUIConfiguration:(void(NS_NOESCAPE ^)(NSFUIButtonBuilder *button))configuration NS_SWIFT_NAME(set(state:withUIConfiguration:));

@end

NS_ASSUME_NONNULL_END
