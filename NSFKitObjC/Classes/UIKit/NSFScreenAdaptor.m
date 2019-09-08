//
//  NSFScreenAdaptor.m
//  TQMall
//
//  Created by shlexingyu on 2018/10/13.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFScreenAdaptor.h"
#import "UIApplication+NSFExt.h"

@interface NSFScreenAdaptor ()
@property (nonatomic, assign, readonly) NSFDeviceWidth baseLineWidth;

@end


@implementation NSFScreenAdaptor

+ (instancetype)sharedInstance
{
    static NSFScreenAdaptor *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NSFScreenAdaptor alloc] initWithBaseLineWidth:NSFDeviceWidth375];
    });
    
    return instance;
}

- (instancetype)initWithBaseLineWidth:(NSFDeviceWidth)width
{
    if (self = [super init])
    {
        _baseLineWidth = width;
    }
    
    return self;
}

#pragma mark - Public
+ (UIEdgeInsets)safeArea
{
    if (@available(iOS 11.0, *))
    {
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] nsf_keyWindow].safeAreaInsets;
        if (@available(iOS 12.0, *))
        {
            // iOS 12 上非刘海屏，top 会是 20，而 iOS 11 上是 0.
            // safeArea 目前的直观用途是适配刘海屏，因此这里将 20 抹去
            if (safeArea.top == 20)
            {
                safeArea.top = 0;
            }
        }
        
        return safeArea;
    }
    
    return UIEdgeInsetsZero;
}

+ (CGFloat)widthFactor
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width /self.baseLineWidth;
}

+ (BOOL)narrowerThanBaseLine
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width < self.baseLineWidth;
}

#pragma mark - Property
+ (NSFDeviceWidth)baseLineWidth
{
    return [NSFScreenAdaptor sharedInstance].baseLineWidth;
}

@end
