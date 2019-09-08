//
//  UITableView+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/12.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UITableView+NSFExt.h"
#import "UITableViewCell+NSFExt.h"
#import "UIView+NSFExt.h"

@implementation UITableView (NSFExt)

- (void)nsf_registerCell:(Class)cellClass
{
    if ([cellClass isSubclassOfClass:[UITableViewCell class]])
    {
        NSString *nibName = NSStringFromClass(cellClass);
        if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
        {
            [self registerNib:[cellClass nsf_nib] forCellReuseIdentifier:[cellClass reuseID]];
        }
        else
        {
            [self registerClass:cellClass forCellReuseIdentifier:[cellClass reuseID]];
        }
    }
}

- (void)nsf_registerSectionHeaderFooterView:(Class)viewClass
{
    if ([viewClass isSubclassOfClass:[UITableViewHeaderFooterView class]])
    {
        NSString *nibName = NSStringFromClass(viewClass);
        if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
        {
            [self registerNib:[viewClass nsf_nib] forHeaderFooterViewReuseIdentifier:[viewClass reuseID]];
        }
        else
        {
            [self registerClass:viewClass forHeaderFooterViewReuseIdentifier:[viewClass reuseID]];
        }
    }
}

- (void)nsf_setSeparatorImage:(UIImage *)image
{
    self.separatorColor = [UIColor colorWithPatternImage:image];
}

- (void)nsf_setSeparatorStyleDashLine:(UIColor *)color
{
    [self nsf_setSeparatorImage:[UITableView nsf_dashLineImage:color]];
}

#pragma mark - Private
+ (UIImage *)nsf_dashLineImage:(UIColor *)color
{
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.f);
    CGFloat lengths[] = {2, 3};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, 0);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextStrokePath(context);
    
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return backgroundImage;
}

- (void)nsf_disableEstimatedHeight
{
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

- (void)nsf_performBatchUpdates:(void(NS_NOESCAPE^)(void))updates
                    completion:(void(^)(BOOL finished))completion
{
    if (@available(iOS 11.0, *))
    {
        [self performBatchUpdates:updates completion:completion];
    }
    else
    {
        [self beginUpdates];
        !updates ?: updates();
        [self endUpdates];
        
        !completion ?: completion(YES);
    }
}

- (void)nsf_removeTopPadding4GroupedTableView
{
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (void)nsf_removeBottomPadding4GroupedTableView
{
    if (self.style == UITableViewStyleGrouped)
    {
        UIEdgeInsets contentInset = self.contentInset;
        contentInset.bottom = -20;
        self.contentInset = contentInset;
    }
}

@end
