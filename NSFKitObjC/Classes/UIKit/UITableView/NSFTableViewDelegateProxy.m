//
//  NSFTableViewDelegateProxy.m
//
//  Created by 乐星宇 on 16/9/8.
//  Copyright © 2016年 lxzhh. All rights reserved.
//

#import "NSFTableViewDelegateProxy.h"
#import <objc/runtime.h>

@interface NSFTableViewDelegateProxy()
@property (nonatomic, weak, readonly) UIViewController<NSFAllOptionalTableViewDataSource, UITableViewDelegate> *viewController;
@property (nonatomic, weak, readonly) id<NSFAllOptionalTableViewDataSource, UITableViewDelegate> viewModel;
@property (nonatomic, assign) SEL cellForRowAtIndexPath;
@property (nonatomic, assign) SEL didSelectRowAtIndexPath;

@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation NSFTableViewDelegateProxy
#pragma clang diagnostic pop

- (instancetype)initWithViewController:(UIViewController<NSFAllOptionalTableViewDataSource, UITableViewDelegate> *)viewController
                             viewModel:(id<NSFAllOptionalTableViewDataSource, UITableViewDelegate>)viewModel
{
    if (self = [super initWithDelegates:@[viewController, viewModel] weakRef:YES])
    {
        _viewController = viewController;
        _viewModel = viewModel;
        
        self.cellForRowAtIndexPath = @selector(tableView:cellForRowAtIndexPath:);
        self.didSelectRowAtIndexPath = @selector(tableView:didSelectRowAtIndexPath:);
    }
    
    return self;
}

#pragma mark - Rule
- (id<NSObject>)delegateRules:(SEL)selector
{
    if (selector == self.cellForRowAtIndexPath)
    {
        return self.viewController;
    }
    else if (selector == self.didSelectRowAtIndexPath)
    {
        if ([self.viewController respondsToSelector:selector])
        {
            return self.viewController;
        }
    }
    else if ([self.viewController respondsToSelector:selector])
    {
        return self.viewController;
    }
    else if ([self.viewModel respondsToSelector:selector])
    {
        return self.viewModel;
    }
    
    return nil;
}

@end
