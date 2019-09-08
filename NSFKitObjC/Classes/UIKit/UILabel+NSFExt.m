//
//  UILabel+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/8.
//

#import "UILabel+NSFExt.h"
#import <objc/runtime.h>

@implementation UILabel (NSFExt)

- (void)nsf_setFontSize:(CGFloat)fontSize
{
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (CGFloat)nsf_fontSize
{
    return self.font.pointSize;
}

- (void)nsf_setBoldFontSize:(CGFloat)boldFontSize
{
    self.font = [UIFont boldSystemFontOfSize:boldFontSize];
}

- (CGFloat)nsf_boldFontSize
{
    return self.font.pointSize;
}

- (void)nsf_setMediumWeightWithFontSize:(CGFloat)size
{
    self.font = [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

- (void)nsf_setRegularWeightWithFontSize:(CGFloat)size
{
    self.font = [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

#pragma mark - 复制
- (BOOL)nsf_copyable
{
    return [objc_getAssociatedObject(self, @selector(nsf_copyable)) boolValue];
}

- (void)nsf_setCopyable:(BOOL)copyable
{
    if (self.nsf_copyable == copyable)
    {
        return;
    }
    
    objc_setAssociatedObject(self, @selector(nsf_copyable), @(copyable), OBJC_ASSOCIATION_ASSIGN);
    
    self.userInteractionEnabled = copyable;
    if (self.longPressGestureRecognizer)
    {
        [self removeGestureRecognizer:self.longPressGestureRecognizer];
        self.longPressGestureRecognizer = nil;
    }
    
    if (copyable)
    {
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

- (dispatch_block_t)nsf_customCopyAction
{
    return objc_getAssociatedObject(self, @selector(nsf_customCopyAction));
}

- (void)nsf_setCustomCopyAction:(dispatch_block_t)nsf_customCopyAction
{
    objc_setAssociatedObject(self, @selector(nsf_customCopyAction), nsf_customCopyAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    return objc_getAssociatedObject(self, @selector(longPressGestureRecognizer));
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    objc_setAssociatedObject(self, @selector(longPressGestureRecognizer), longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)longPressGestureRecognized:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self becomeFirstResponder];
        
        UIMenuController *copyMenu = [UIMenuController sharedMenuController];
        [copyMenu setTargetRect:self.bounds inView:self];
        copyMenu.arrowDirection = UIMenuControllerArrowDefault;
        [copyMenu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - UIResponder(复制)
- (BOOL)canBecomeFirstResponder
{
    return self.nsf_copyable;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return self.nsf_copyable && (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    if (self.nsf_copyable)
    {
        if (self.nsf_customCopyAction)
        {
            self.nsf_customCopyAction();
        }
        else
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            if (self.text)
            {
                [pasteboard setString:self.text];
            }
            else if (self.attributedText)
            {
                [pasteboard setString:self.attributedText.string];
            }
        }
    }
}

@end
