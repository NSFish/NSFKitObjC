//
//  NSFLoadingIndicatorProtocol.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFLoadingIndicator <NSObject>

/**
 显示 HUD，添加在指定的 view 上
 
 @param view 指定的 view
 @param userInteractionEnabled 显示时下方 UI 是否能交互，默认为 NO
 */
- (void)showInView:(UIView *)view userInteractionEnabled:(BOOL)userInteractionEnabled;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
