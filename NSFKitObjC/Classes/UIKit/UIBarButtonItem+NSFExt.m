//
//  UIBarButtonItem+NSFExt.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/22.
//

#import "UIBarButtonItem+NSFExt.h"
#import <objc/runtime.h>

@interface UIBarButtonItem ()
@property (nonatomic, copy, setter=nsf_setBlock:) NSFBarButtonItemBlock nsf_block;

@end


@implementation UIBarButtonItem (NSFExt)

- (instancetype)initWithTitle:(NSString *)title
                     UIConfig:(NSFBarButtonUIConfig)UIConfig
                        block:(NSFBarButtonItemBlock)block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:title forState:UIControlStateNormal];
    
    if (self = [self initWithCustomView:button])
    {
        [button addTarget:self action:@selector(invokeBlock:) forControlEvents:UIControlEventTouchUpInside];
        !UIConfig ?: UIConfig(button);
        self.nsf_block = block;
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                     UIConfig:(NSFBarButtonUIConfig)UIConfig
                        block:(NSFBarButtonItemBlock)block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -(44 - image.size.width), 0, 0);
    
    if (self = [self initWithCustomView:button])
    {
        [button addTarget:self action:@selector(invokeBlock:) forControlEvents:UIControlEventTouchUpInside];
        !UIConfig ?: UIConfig(button);
        self.nsf_block = block;
    }
    
    return self;
}

+ (instancetype)instanceWithTitle:(NSString *)title
                         UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                            block:(NSFBarButtonItemBlock)block
{
    return [[self alloc] initWithTitle:title UIConfig:UIConfig block:block];
}

+ (instancetype)instanceWithImage:(UIImage *)image
                         UIConfig:(nullable NSFBarButtonUIConfig)UIConfig
                            block:(NSFBarButtonItemBlock)block
{
    return [[self alloc] initWithImage:image UIConfig:UIConfig block:block];
}

#pragma mark - Action
- (void)invokeBlock:(UIBarButtonItem *)item
{
    !self.nsf_block ?: self.nsf_block(self);
}

#pragma mark - Property
- (NSFBarButtonItemBlock)nsf_block
{
    return objc_getAssociatedObject(self, @selector(nsf_block));
}

- (void)nsf_setBlock:(NSFBarButtonItemBlock)nsf_block
{
    objc_setAssociatedObject(self, @selector(nsf_block), nsf_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
