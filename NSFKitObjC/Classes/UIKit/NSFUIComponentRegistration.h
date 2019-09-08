//
//  NSFUIComponentRegistration.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFUIComponentRegistration : NSObject

+ (void)registerUICompomnent:(Class)componentClass conformTo:(Protocol *)protocol;
+ (void)unregisterUICompomnent:(Class)componentClass conformTo:(Protocol *)protocol;

+ (nullable Class)UIComponent4Protocol:(Protocol *)protocol;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
