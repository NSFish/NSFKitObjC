//
//  UIApplication+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/7.
//

#import "UIApplication+NSFExt.h"

@implementation UIApplication (NSFExt)

- (UIWindow *)nsf_keyWindow
{
    return [self.windows firstObject];
}

@end
