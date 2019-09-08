//
//  NSFContainerViewControllerProtocol.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFContainerViewController <NSObject>
@property (readonly, nullable) UIViewController *currentContentVC;

- (void)setContentViewControllers:(nullable NSArray<UIViewController *> *)viewControllers;

@optional
- (void)setCurrentContentVC:(nullable UIViewController *)currentContentVC animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
