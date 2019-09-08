//
//  NSFScreenAdaptor.h
//  TQMall
//
//  Created by shlexingyu on 2018/10/13.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NSFDeviceWidth)
{
    NSFDeviceWidth320 = 320,
    NSFDeviceWidth375 = 375,
    NSFDeviceWidth414 = 414
};

@interface NSFScreenAdaptor : NSObject

/**
 基准设备的宽度，默认为 375
 */
@property (class, readonly) NSFDeviceWidth baseLineWidth;

/**
 兼容低版本获取 Safe Area 的 wrapper

 @return  在 iOS 11 及以上返回d keyWindow.safeArea，更低版本上返回 UIEdgeInsetsZero
 */
+ (UIEdgeInsets)safeArea;

/**
 获取当前设备与基准设备的宽度比
 */
+ (CGFloat)widthFactor;

+ (BOOL)narrowerThanBaseLine;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
