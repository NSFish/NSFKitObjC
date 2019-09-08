//
//  NSFContentViewController.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import "NSFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 将内容 VC 加载的过程状态化

 - NSFContentViewControllerStateIdle: VC 初始化到请求数据前的状态
 - NSFContentViewControllerStateLoading: 正在加载数据
 - NSFContentViewControllerStateSuccess: 加载数据成功
 - NSFContentViewControllerStateFailed: 加载数据失败
 */
typedef NS_ENUM(NSUInteger, NSFContentViewControllerState)
{
    NSFContentViewControllerStateIdle,
    NSFContentViewControllerStateLoading,
    NSFContentViewControllerStateSuccess,
    NSFContentViewControllerStateFailed
};

@interface NSFContentViewController : NSFBaseViewController

/**
 加载数据的状态
 */
@property (nonatomic, assign) NSFContentViewControllerState state;

- (void)showLoadingIndicator;
- (void)showLoadingIndicatorInView:(UIView *)view;

- (void)hideLoadingIndicator;

@end

NS_ASSUME_NONNULL_END
