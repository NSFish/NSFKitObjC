//
//  NSFPrioritizedDelegate.m
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFPrioritizedDelegate.h"

@interface NSFPrioritizedDelegate ()
@property (nonatomic, strong) NSPointerArray *delegates;
@property (nonatomic, strong) NSArray *strongDelegates;

@end


@implementation NSFPrioritizedDelegate

- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef
{
    if (self = [super init])
    {
        self.delegates = [NSPointerArray weakObjectsPointerArray];
        for (id delegate in delegates)
        {
            [self.delegates addPointer:(__bridge void*)delegate];
        }
        
        if (!weakRef)
        {
            self.strongDelegates = delegates;
        }
    }
    
    return self;
}

#pragma mark - Overridable
- (id<NSObject>)delegateRules:(SEL)selector
{
    for (id<NSObject> delegate in self.delegates)
    {
        if ([delegate respondsToSelector:selector])
        {
            return delegate;
        }
    }
    
    return nil;
}

#pragma mark - Forwarding
- (BOOL)respondsToSelector:(SEL)selector
{
    return [self delegateRules:selector] != nil;
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    return [self delegateRules:selector];
}

@end
