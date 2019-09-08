//
//  UIApplication+NSFExt.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (NSFExt)

/**
 始终返回 App 初始化时的 keyWindow, 兼容各种自定义的 UIWindow.
 */
- (UIWindow *)nsf_keyWindow;

@end

NS_ASSUME_NONNULL_END
