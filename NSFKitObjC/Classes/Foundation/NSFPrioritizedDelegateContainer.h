//
//  NSFPrioritizedDelegateContainer.h
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFPrioritizedDelegate : NSObject
@property (readonly) id<NSObject> content;

/// 是否需要在 container 中弱引用 delegate
@property (readonly) BOOL weakRef;

- (instancetype)initWithContent:(id<NSObject>)content
                        weakRef:(BOOL)weakRef NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end


/**
 为指定 protocol 的 delegate 提供多个 implementations，每一次方法调用都只会有一个 implementation 胜出并响应该调用。可以用于不同层级间的依赖注入。
 */
@interface NSFPrioritizedDelegateContainer : NSObject

- (instancetype)initWithPrioritizedDelegate:(NSArray<NSFPrioritizedDelegate *> *)delegates NS_DESIGNATED_INITIALIZER;

/**
 统一指定是否弱引用所有 delegates 的 convenient initializer
 */
- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - Overridable
/**
 Subclass可以override此方法来改变不同的delegate响应不同selector时的优先级
 */
- (nullable id<NSObject>)delegateRules:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
