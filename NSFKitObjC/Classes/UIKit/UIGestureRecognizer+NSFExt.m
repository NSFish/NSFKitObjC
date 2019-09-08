//
//  UIGestureRecognizer+NSFExt.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/14.
//

#import "UIGestureRecognizer+NSFExt.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer ()
@property (nonatomic, copy) NSFGestureRecognizerBlock block;

@end


@implementation UIGestureRecognizer (NSFExt)

+ (instancetype)gestureRecognizerWithBlock:(NSFGestureRecognizerBlock)block
{
    return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(NSFGestureRecognizerBlock)block
{
    if (self = [self init])
    {
        self.block = block;
        [self addTarget:self action:@selector(invokeBlock:)];
    }
    
    return self;
}

- (void)invokeBlock:(UIGestureRecognizer *)gesture
{
    !self.block ?: self.block(gesture);
}

#pragma mark - Public
- (void)nsf_cancel
{
    // https://stackoverflow.com/a/4167471/2135264
    self.enabled = NO;
    self.enabled = YES;
}

#pragma mark - Property
- (void)setBlock:(NSFGestureRecognizerBlock)block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSFGestureRecognizerBlock)block
{
    return objc_getAssociatedObject(self, @selector(block));
}

@end
