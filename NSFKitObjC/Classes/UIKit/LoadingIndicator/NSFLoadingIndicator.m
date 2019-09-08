//
//  NSFLoadingIndicator.m
//  AWSCore
//
//  Created by shlexingyu on 2019/3/21.
//

#import "NSFLoadingIndicator.h"
#import "NSFInternalLoadingIndicator.h"
#import "UIApplication+NSFExt.h"
#import "NSFUIComponentRegistration.h"

@implementation NSFLoadingIndicator

+ (id<NSFLoadingIndicator>)loadingIndicator
{
    Class class = [NSFUIComponentRegistration UIComponent4Protocol:@protocol(NSFLoadingIndicatorContentView)];
    return [[NSFInternalLoadingIndicator alloc] initWithLoadingView:[class instance]];
}

+ (void)showGlobalLoadingIndicator
{
    [[self globalLoadingIndicator] showInView:[[UIApplication sharedApplication] nsf_keyWindow]
                       userInteractionEnabled:NO];
}

+ (void)hideGlobalLoadingIndicator
{
    [[self globalLoadingIndicator] hide];
}

#pragma mark - Private
+ (id<NSFLoadingIndicator>)globalLoadingIndicator
{
    static id<NSFLoadingIndicator> instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self loadingIndicator];
    });
    
    return instance;
}

@end
