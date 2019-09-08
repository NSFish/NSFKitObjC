//
//  UIScrollView+NSFExt.m
//  TQMall
//
//  Created by shlexingyu on 2019/3/14.
//  Copyright © 2019年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UIScrollView+NSFExt.h"
#import "NSFLightweightGenericSupport.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface UIScrollView (Private)
@property (nonatomic, strong) MArray(UIView) pageViews;

@end


@implementation UIScrollView (NSFExt)

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated
{
    if (self.currentPage == page)
    {
        return;
    }
    
    self.currentPage = page;
    
    if (CGRectEqualToRect(self.frame, CGRectZero)
        || CGSizeEqualToSize(self.contentSize, CGSizeZero))
    {
        @weakify(self);
        [[[self rac_signalForSelector:@selector(layoutSubviews)] take:1]
         subscribeNext:^(id _) {
             @strongify(self);

             CGRect frame = self.frame;
             frame.origin.x = frame.size.width * page;
             frame.origin.y = 0;

             [self scrollRectToVisible:frame animated:animated];
         }];
    }
    else
    {
        CGRect frame = self.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        
        [self scrollRectToVisible:frame animated:animated];
    }
}

#pragma mark - Public
- (void)addNotLastPageView:(UIView *)view
{
    [self nsf_commonSetupToPageView:view];
    
    UIView *previousView = [self.pageViews lastObject];
    if (!previousView)
    {
        UIView *contentContainerView = [self nsf_contentContainerView];
        [view.leftAnchor constraintEqualToAnchor:contentContainerView.leftAnchor].active = YES;
    }
    else
    {
        [view.leftAnchor constraintEqualToAnchor:previousView.rightAnchor].active = YES;
    }
    
    [self nsf_save:view];
}

- (void)addLastPageView:(UIView *)view
{
    [self addNotLastPageView:view];
    
    UIView *contentContainerView = [self nsf_contentContainerView];
    [view.rightAnchor constraintEqualToAnchor:contentContainerView.rightAnchor].active = YES;
    
    [self nsf_save:view];
}

#pragma mark - Private
static NSInteger kContentContainerViewTag = 10086;
- (UIView *)nsf_contentContainerView
{
    UIView *contentContainerView = [self viewWithTag:kContentContainerViewTag];
    if (!contentContainerView)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        contentContainerView = [UIView new];
        contentContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        contentContainerView.tag = kContentContainerViewTag;
        [self addSubview:contentContainerView];
        
        [contentContainerView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [contentContainerView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [contentContainerView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [contentContainerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        // https://developer.apple.com/library/ios/technotes/tn2154/_index.html
        // ScrollView 的 contentView 不能依赖于 scrollView 本身的 bounds
        [contentContainerView.heightAnchor constraintEqualToAnchor:self.superview.heightAnchor].active = YES;
    }
    
    return contentContainerView;
}

- (void)nsf_commonSetupToPageView:(UIView *)view
{
    UIView *contentContainerView = [self nsf_contentContainerView];
    [contentContainerView addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.topAnchor constraintEqualToAnchor:contentContainerView.topAnchor].active = YES;
    [view.bottomAnchor constraintEqualToAnchor:contentContainerView.bottomAnchor].active = YES;
    [view.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
}

- (void)nsf_save:(UIView *)contentView
{
    if (!self.pageViews)
    {
        self.pageViews = [NSMutableArray new];
    }
    
    [self.pageViews addObject:contentView];
}

#pragma mark - Property
- (NSUInteger)totalPage
{
    return self.pageViews.count;
}

- (NSUInteger)currentPage
{
    NSNumber *currentPage = objc_getAssociatedObject(self, @selector(currentPage));
    return currentPage.integerValue;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    objc_setAssociatedObject(self, @selector(currentPage), @(currentPage), OBJC_ASSOCIATION_ASSIGN);
}

- (MArray(UIView))pageViews
{
    return objc_getAssociatedObject(self, @selector(pageViews));
}

- (void)setPageViews:(MArray(UIView))contentViews
{
    objc_setAssociatedObject(self, @selector(pageViews), contentViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
