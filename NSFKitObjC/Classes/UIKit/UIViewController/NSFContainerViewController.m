//
//  NSFContainerViewController.m
//  TQMall
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFContainerViewController.h"

@interface NSFContainerViewController()
@property (nonatomic, strong) UIViewController *currentContentVC;

/**
 *  在 container vc 执行vc生命周期方法前，所有的 content vc 都不应该执行对应方法
 *  此状态成员用于在setCurrentContentViewController中进行判断
 */
@property (nonatomic, assign) BOOL containerWillAppearDone;
@property (nonatomic, assign) BOOL containerDidAppearDone;

@end


@implementation NSFContainerViewController

#pragma mark - Life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.currentContentVC beginAppearanceTransition:YES animated:animated];
    self.containerWillAppearDone = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.currentContentVC endAppearanceTransition];
    self.containerDidAppearDone = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.currentContentVC beginAppearanceTransition:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.currentContentVC endAppearanceTransition];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    if (!parent)
    {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *vc, NSUInteger idx, BOOL *stop) {
            [vc willMoveToParentViewController:nil];
        }];
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    if (!parent)
    {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *vc, NSUInteger idx, BOOL *stop) {
            [self removeContentViewController:vc];
        }];
    }
}

#pragma mark - ContentVC 添加、移除
- (void)addContentViewController:(UIViewController *)vc addToViewHierarchyAccordingly:(BOOL)addToViewHierarchyAccordingly
{
    if (addToViewHierarchyAccordingly)
    {
        [self addContentViewController:vc autolayoutConfig:^{
            NSLayoutConstraint *left = [vc.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
            NSLayoutConstraint *right = [vc.view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
            NSLayoutConstraint *top = [vc.view.topAnchor constraintEqualToAnchor:self.view.topAnchor];
            NSLayoutConstraint *bottom = [vc.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
            [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
        }];
    }
    else
    {
        //这里会自动调用[vc willMoveToParentViewController:self]
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
}

- (void)addContentViewController:(UIViewController *)vc
                autolayoutConfig:(dispatch_block_t NS_NOESCAPE)autolayoutConfig
{
    [self addContentViewController:vc superView:self.view autolayoutConfig:autolayoutConfig];
}

- (void)addContentViewController:(UIViewController *)vc
                       superView:(UIView *)superView
                autolayoutConfig:(dispatch_block_t NS_NOESCAPE)autolayoutConfig
{
    //这里会自动调用[vc willMoveToParentViewController:self]
    [self addChildViewController:vc];
    [superView addSubview:vc.view];
    
    !autolayoutConfig ?: autolayoutConfig();
    
    [vc didMoveToParentViewController:self];
    
    if (!self.currentContentVC)
    {
        self.currentContentVC = vc;
    }
}

- (void)removeContentViewController:(UIViewController *)vc
{
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

- (void)removeAllContentVCs
{
    [self.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeContentViewController:obj];
    }];
}

#pragma mark - 手动控制viewWillAppear等方法的调用时间
- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

#pragma mark - NSFContainerViewController
- (NSArray<UIViewController *> *)contentViewControllers
{
    return self.childViewControllers;
}

- (void)setContentViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    if (viewControllers.count == 0)
    {
        [self removeAllContentVCs];
    }
    else
    {
        [viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
            [self addContentViewController:vc autolayoutConfig:nil];
        }];
    }
}

- (void)setCurrentContentViewController:(UIViewController *)vc
{
    [self setCurrentContentVC:vc animated:NO];
}

- (void)setCurrentContentVC:(UIViewController *)vc animated:(BOOL)animated
{
    if (self.currentContentVC == vc)
    {
        return;
    }
    else if (![self.childViewControllers containsObject:vc])
    {
        return;
    }
    
    UIViewController *oldCurrentViewController = self.currentContentVC;
    if (oldCurrentViewController)
    {
        //willDisappear
        [oldCurrentViewController beginAppearanceTransition:NO animated:animated];
        //didDisappear
        [oldCurrentViewController endAppearanceTransition];
    }
    
    _currentContentVC = vc;
    if (_currentContentVC)
    {
        //willAppear
        if (self.containerWillAppearDone)
        {
            [_currentContentVC beginAppearanceTransition:YES animated:animated];
        }
        
        //didAppear
        if (self.containerDidAppearDone)
        {
            [_currentContentVC endAppearanceTransition];
        }
    }
}

@end

