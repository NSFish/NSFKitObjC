//
//  UIBarButtonItem+NSFExt.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NSFBarButtonUIConfig)(UIButton *button);
typedef void(^NSFBarButtonItemBlock)(UIBarButtonItem *item);

@interface UIBarButtonItem (NSFExt)

- (instancetype)initWithTitle:(NSString *)title
                     UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                        block:(NSFBarButtonItemBlock)block;

- (instancetype)initWithImage:(UIImage *)image
                     UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                        block:(NSFBarButtonItemBlock)block;

+ (instancetype)instanceWithTitle:(NSString *)title
                         UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                            block:(NSFBarButtonItemBlock)block;

+ (instancetype)instanceWithImage:(UIImage *)image
                         UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                            block:(NSFBarButtonItemBlock)block;

@end

NS_ASSUME_NONNULL_END
