//
//  NSTimer+NSFExt.h
//  TQMall
//
//  Created by NSFish on 2018/10/24.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 主要做两件事：
 1. 防止 NSTimer 强引用 target 导致内存泄漏
 2. (不论是否 repeat)当不再需要 Timer 时，会自动在创建 timer 的线程中调用 invalidate，无需外部干预
 */
@interface NSTimer (NSFExt)

+ (NSTimer *)nsf_timerWithTimeInterval:(NSTimeInterval)interval
                                block:(void (^)(NSTimer * _Nonnull))block
                             userInfo:(nullable id)userInfo
                          repeatUntil:(nullable BOOL(^)(void))shouldStop
                              finally:(nullable dispatch_block_t)finally NS_SWIFT_NAME(init(timeInterval:block:userInfo:repeatUntil:finally:));

+ (NSTimer *)nsf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void (^)(NSTimer *timer))block
                                      userInfo:(nullable id)userInfo
                                   repeatUntil:(nullable BOOL(^)(void))shouldStop
                                       finally:(nullable dispatch_block_t)finally NS_SWIFT_NAME(scheduledTimer(withTimeInterval:block:userInfo:repeatUntil:finally:));

+ (NSTimer *)nsf_timerWithTimeInterval:(NSTimeInterval)interval
                               target:(id)target
                             selector:(SEL)selector
                             userInfo:(nullable id)userInfo
                          repeatUntil:(nullable BOOL(^)(void))shouldStop
                              finally:(nullable dispatch_block_t)finally NS_SWIFT_NAME(init(timeInterval:target:selector:userInfo:repeatUntil:finally:));

+ (NSTimer *)nsf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(nullable id)userInfo
                                   repeatUntil:(nullable BOOL(^)(void))shouldStop
                                       finally:(nullable dispatch_block_t)finally NS_SWIFT_NAME(scheduledTimer(withTimeInterval:target:selector:userInfo:repeatUntil:finally:));

@end

NS_ASSUME_NONNULL_END
