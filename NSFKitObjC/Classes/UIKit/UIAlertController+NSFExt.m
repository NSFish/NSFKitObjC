//
//  UIAlertController+NSFExt.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/12.
//

#import "UIAlertController+NSFExt.h"
#import "NSObject+NSFExt.h"

@implementation UIAlertController (NSFExt)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self nsf_swizzleMethod:@selector(viewDidLayoutSubviews)
                    withMethod:@selector(nsf_viewDidLayoutSubviews)
                         error:nil];
    });
}

#pragma mark - Bug fix
/**
 *  UIAlertController 在 present 其他 VC 之后，自身的显示就会变得很诡异，这里强制修正它的 frame
 *  http://stackoverflow.com/a/28862536/2135264
 */
- (void)nsf_viewDidLayoutSubviews
{
    [self nsf_viewDidLayoutSubviews];
    [self nsf_fixLayout];
}

- (void)nsf_fixLayout
{
    if (self.preferredStyle == UIAlertControllerStyleAlert && self.view.window)
    {
        CGRect myRect = self.view.bounds;
        CGRect windowRect = [self.view convertRect:myRect toView:nil];
        if (!CGRectContainsRect(self.view.window.bounds, windowRect) || CGPointEqualToPoint(windowRect.origin, CGPointZero))
        {
            CGPoint center = self.view.window.center;
            CGPoint myCenter = [self.view.superview convertPoint:center fromView:nil];
            self.view.center = myCenter;
        }
    }
    else if (self.preferredStyle == UIAlertControllerStyleActionSheet && self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPhone && self.view.window)
    {
        CGRect myRect = self.view.bounds;
        CGRect windowRect = [self.view convertRect:myRect toView:nil];
        if (!CGRectContainsRect(self.view.window.bounds, windowRect) || CGPointEqualToPoint(windowRect.origin, CGPointZero))
        {
            UIScreen *screen = self.view.window.screen;
            CGFloat borderPadding = ((screen.nativeBounds.size.width / screen.nativeScale) - myRect.size.width) / 2.0f;
            CGRect myFrame = self.view.frame;
            CGRect superBounds = self.view.superview.bounds;
            myFrame.origin.x = CGRectGetMidX(superBounds) - myFrame.size.width / 2;
            myFrame.origin.y = superBounds.size.height - myFrame.size.height - borderPadding;
            self.view.frame = myFrame;
        }
    }
}

@end
