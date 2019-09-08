//
//  NSFContentViewController.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import "NSFContentViewController.h"
#import "NSFLoadingIndicator.h"

@interface NSFContentViewController ()
@property (nonatomic, strong) id<NSFLoadingIndicator> loadingIndicator;

@end


@implementation NSFContentViewController

#pragma mark - Public
- (void)showLoadingIndicator
{
    [self showLoadingIndicatorInView:self.view];
}

- (void)showLoadingIndicatorInView:(UIView *)view
{
    if (!self.loadingIndicator)
    {
        self.loadingIndicator = [NSFLoadingIndicator loadingIndicator];
    }
    
    [self.loadingIndicator showInView:view userInteractionEnabled:YES];
}

- (void)hideLoadingIndicator
{
    [self.loadingIndicator hide];
}

@end
