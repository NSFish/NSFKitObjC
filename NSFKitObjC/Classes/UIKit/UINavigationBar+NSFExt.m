//
//  UINavigationBar+NSFExt.m
//  TQMall
//
//  Created by shlexingyu on 2019/3/14.
//  Copyright © 2019年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UINavigationBar+NSFExt.h"
#import "UIImage+NSFExt.h"

@implementation UINavigationBar (NSFExt)

- (void)nsf_hideBottomShadow
{
    UIImage *emptyImage = [UIImage imageWithColor:[UIColor whiteColor]];
    [self setBackgroundImage:emptyImage forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = emptyImage;
}

- (void)nsf_showBottomShadow
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = nil;
}

@end
