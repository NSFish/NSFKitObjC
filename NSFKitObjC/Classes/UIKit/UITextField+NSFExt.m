//
//  UITextField+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/12/17.
//

#import "UITextField+NSFExt.h"
#import "NSObject+NSFExt.h"
#import <objc/runtime.h>

@implementation UITextField (NSFExt)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self nsf_swizzleMethod:@selector(caretRectForPosition:) withMethod:@selector(nsf_caretRectForPosition:) error:nil];
    });
}

#pragma mark - Swizzle
- (CGRect)nsf_caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [self nsf_caretRectForPosition:position];
    
    if (self.nsf_cursorHeight > 0
        && self.nsf_cursorHeight < originalRect.size.height)
    {
        originalRect.origin.y += (originalRect.size.height - self.nsf_cursorHeight) / 2;
        originalRect.size.height = self.nsf_cursorHeight;
    }
    
    return originalRect;
}

#pragma mark - Property
- (CGFloat)nsf_cursorHeight
{
    return [objc_getAssociatedObject(self, @selector(nsf_cursorHeight)) floatValue];
}

- (void)nsf_setCursorHeight:(CGFloat)cursorHeight
{
    objc_setAssociatedObject(self, @selector(nsf_cursorHeight), @(cursorHeight), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
