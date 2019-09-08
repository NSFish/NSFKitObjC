//
//  NSFButton.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/2.
//

#import "UIButton+NSFExt.h"

NS_ASSUME_NONNULL_BEGIN

/**
 原有的 UIControlState, 在组合使用来时多有不便. 比如 UIControlStateDisabled | UIControlStateSelected,
 要在合适的时机设置 enabled 和 selected，很容易出错。
 CustomState 支持自定义状态, 用法
 1. 定义自定义状态 enum
 2. 将自定义 enum 映射到 UIControlState 上(nsf_mapCustomState:toState:)
 3. 设置不同自定义状态下的 UI 样式
 4. 在合适的时机修改 currentCustomState(自动设置 enabled 和 selected 的相应值)
 */
@interface NSFButton : UIButton

@property (nonatomic, assign, setter=nsf_setCurrentCustomState:) NSUInteger nsf_currentCustomState;

- (void)nsf_mapCustomState:(NSUInteger)customState toState:(UIControlState)state;
- (void)nsf_setCustomState:(NSUInteger)customState
      withUIConfiguration:(void(NS_NOESCAPE ^)(NSFUIButtonBuilder *button))configuration;

- (void)nsf_setTitle:(nullable NSString *)title forCustomState:(NSUInteger)customState;
- (void)nsf_setTitleColor:(nullable UIColor *)color forCustomState:(NSUInteger)customState;
- (void)nsf_setTitleShadowColor:(nullable UIColor *)color forCustomState:(NSUInteger)customState;
- (void)nsf_setImage:(nullable UIImage *)image forCustomState:(NSUInteger)customState;
- (void)nsf_setBackgroundImage:(nullable UIImage *)image forCustomState:(NSUInteger)customState;
- (void)nsf_setAttributedTitle:(nullable NSAttributedString *)title forCustomState:(NSUInteger)customState;

@end

NS_ASSUME_NONNULL_END
