//
//  NSTimer+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/24.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSTimer+NSFExt.h"

@interface NSFTimerTargetWrapper : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) void(^block)(NSTimer *timer);
@property (nonatomic, copy) BOOL(^shouldStop)(void);
@property (nonatomic, copy) dispatch_block_t finally;

@end


@implementation NSFTimerTargetWrapper

- (void)dealloc
{
    !self.finally ?: self.finally();
}

#pragma mark - Private
- (void)timerCallback:(NSTimer *)timer
{
    if (self.target)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer afterDelay:0.f];
#pragma clang diagnostic pop
    }
    else if (self.block)
    {
        self.block(timer);
    }
    
    BOOL shouldStop = !self.shouldStop ?: self.shouldStop();
    if ((!self.target && !self.block)) // 如果外部回调已经不存在了，说明不再需要 timer 了
    {
        shouldStop = YES;
    }
    
    if (shouldStop)
    {
        self.block = nil;
        self.shouldStop = nil;
        
        [timer invalidate];
    }
}

@end


@implementation NSTimer (NSFExt)

+ (NSTimer *)nsf_timerWithTimeInterval:(NSTimeInterval)interval
                                block:(void (^)(NSTimer *))block
                             userInfo:(nullable id)userInfo
                          repeatUntil:(BOOL(^)(void))shouldStop
                              finally:(dispatch_block_t)finally
{
    NSFTimerTargetWrapper *wrapper = [NSFTimerTargetWrapper new];
    wrapper.block = block;
    wrapper.shouldStop = shouldStop;
    wrapper.finally = finally;
    
    return [self timerWithTimeInterval:interval
                                target:wrapper
                              selector:@selector(timerCallback:)
                              userInfo:userInfo
                               repeats:(shouldStop != nil)];
}

+ (NSTimer *)nsf_timerWithTimeInterval:(NSTimeInterval)interval
                               target:(id)target
                             selector:(SEL)selector
                             userInfo:(id)userInfo
                          repeatUntil:(BOOL(^)(void))shouldStop
                              finally:(dispatch_block_t)finally
{
    NSFTimerTargetWrapper *wrapper = [NSFTimerTargetWrapper new];
    wrapper.target = target;
    wrapper.selector = selector;
    wrapper.shouldStop = shouldStop;
    wrapper.finally = finally;
    
    return [self timerWithTimeInterval:interval
                                target:wrapper
                              selector:@selector(timerCallback:)
                              userInfo:userInfo
                               repeats:(shouldStop != nil)];
}

+ (NSTimer *)nsf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void (^)(NSTimer *timer))block
                                      userInfo:(id)userInfo
                                   repeatUntil:(BOOL(^)(void))shouldStop
                                       finally:(dispatch_block_t)finally
{
    NSFTimerTargetWrapper *wrapper = [NSFTimerTargetWrapper new];
    wrapper.block = block;
    wrapper.shouldStop = shouldStop;
    wrapper.finally = finally;
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:wrapper
                                       selector:@selector(timerCallback:)
                                       userInfo:userInfo
                                        repeats:(shouldStop != nil)];
}

+ (NSTimer *)nsf_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        target:(id)target
                                      selector:(SEL)selector
                                      userInfo:(id)userInfo
                                   repeatUntil:(BOOL(^)(void))shouldStop
                                       finally:(dispatch_block_t)finally
{
    NSFTimerTargetWrapper *wrapper = [NSFTimerTargetWrapper new];
    wrapper.target = target;
    wrapper.selector = selector;
    wrapper.shouldStop = shouldStop;
    wrapper.finally = finally;
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:wrapper
                                       selector:@selector(timerCallback:)
                                       userInfo:userInfo
                                        repeats:(shouldStop != nil)];
}

@end
