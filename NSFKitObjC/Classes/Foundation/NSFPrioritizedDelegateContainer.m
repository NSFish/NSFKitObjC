//
//  NSFPrioritizedDelegateContainer.m
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFPrioritizedDelegateContainer.h"

@interface NSFPrioritizedDelegate()
@property (nonatomic, strong) id<NSObject> content;
@property (nonatomic, assign) BOOL weakRef;

@end

@implementation NSFPrioritizedDelegate

- (instancetype)initWithContent:(id<NSObject>)content weakRef:(BOOL)weakRef
{
    if (self = [super init])
    {
        self.content = content;
        self.weakRef = weakRef;
    }
    
    return self;
}

@end


@interface NSFPrioritizedDelegateContainer ()
@property (nonatomic, strong) NSPointerArray *delegates;
@property (nonatomic, strong) NSArray *strongDelegates;

@end


@implementation NSFPrioritizedDelegateContainer

- (instancetype)initWithPrioritizedDelegate:(NSArray<NSFPrioritizedDelegate *> *)delegates
{
    if (self = [super init])
    {
        NSMutableArray *strongDelegates = [NSMutableArray array];
        self.delegates = [NSPointerArray weakObjectsPointerArray];
        for (NSFPrioritizedDelegate *delegate in delegates)
        {
            [self.delegates addPointer:(__bridge void*)delegate.content];
            
            NSParameterAssert(delegate.content);
            
            if (!delegate.weakRef)
            {
                [strongDelegates addObject:delegate.content];
            }
        }
        
        self.strongDelegates = [strongDelegates copy];
    }
    
    return self;
}

- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef
{
    NSMutableArray *array = [NSMutableArray array];
    [delegates enumerateObjectsUsingBlock:^(id<NSObject> content, NSUInteger idx, BOOL *stop) {
        NSFPrioritizedDelegate *delegate = [[NSFPrioritizedDelegate alloc] initWithContent:content weakRef:weakRef];
        [array addObject:delegate];
    }];
    
    return [self initWithPrioritizedDelegate:array];
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
