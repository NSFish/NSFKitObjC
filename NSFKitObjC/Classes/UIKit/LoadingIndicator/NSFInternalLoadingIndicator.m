//
//  NSFInternalLoadingIndicator.m
//  TQMall
//
//  Created by Jamin on 13/9/18.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFInternalLoadingIndicator.h"

@interface NSFInternalLoadingIndicator()
@property (nonatomic, strong) UIView<NSFLoadingIndicatorContentView> *contentView;

@end


@implementation NSFInternalLoadingIndicator

- (instancetype)initWithLoadingView:(__kindof UIView<NSFLoadingIndicatorContentView> *)contentView
{
    if (self = [super initWithFrame:CGRectZero])
    {        
        self.contentView = contentView;
        [self addSubview:self.contentView];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    }
    
    return self;
}

#pragma mark - NSFLoadingIndicator
- (void)showInView:(UIView *)view userInteractionEnabled:(BOOL)userInteractionEnabled;
{
    if (self.superview)
    {
        return;
    }
    
    self.userInteractionEnabled = !userInteractionEnabled;
    
    [self.contentView willAppear];
    [view addSubview:self];
    [NSLayoutConstraint activateConstraints:@[[self.leftAnchor constraintEqualToAnchor:view.leftAnchor],
                                              [self.rightAnchor constraintEqualToAnchor:view.rightAnchor],
                                              [self.topAnchor constraintEqualToAnchor:view.topAnchor],
                                              [self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]]];
    [self.contentView didAppear];
}

- (void)hide
{
    if (!self.superview)
    {
        return;
    }
    
    [self.contentView willDisappear];
    [self removeFromSuperview];
    [self.contentView didDisappear];
}

@end
