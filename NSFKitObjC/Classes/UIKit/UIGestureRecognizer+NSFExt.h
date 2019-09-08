//
//  UIGestureRecognizer+NSFExt.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NSFGestureRecognizerBlock)(__kindof UIGestureRecognizer *gesture);

@interface UIGestureRecognizer (NSFExt)

+ (instancetype)gestureRecognizerWithBlock:(NSFGestureRecognizerBlock)block;
- (instancetype)initWithBlock:(NSFGestureRecognizerBlock)block;

/**
 取消当前正在进行中的手势
 */
- (void)nsf_cancel;

@end

NS_ASSUME_NONNULL_END
