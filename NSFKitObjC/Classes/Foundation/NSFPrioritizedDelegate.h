//
//  NSFPrioritizedDelegate.h
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 为指定 protocol 的 delegate 提供多个 implementations，每一次方法调用都只会有一个 implementation 胜出并响应该调用。可以用于不同层级间的依赖注入。
 */
@interface NSFPrioritizedDelegate : NSObject

/**
 生成传入的delegates的wrapper delegate
 
 @param delegates 所有实现了指定protocol的对象
 @param weakRef 是否仅持有所有delegate的弱引用
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
