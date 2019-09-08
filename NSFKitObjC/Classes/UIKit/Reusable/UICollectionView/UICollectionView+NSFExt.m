//
//  UICollectionView+NSFExt.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/15.
//

#import "UICollectionView+NSFExt.h"
#import "UICollectionReusableView+NSFExt.h"
#import "UIView+NSFExt.h"
#import <objc/runtime.h>

@implementation UICollectionView (NSFExt)

- (void)nsf_registerCell:(Class)cellClass
{
    if ([cellClass isSubclassOfClass:[UICollectionViewCell class]])
    {
        NSString *nibName = NSStringFromClass(cellClass);
        if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
        {
            [self registerNib:[cellClass nsf_nib] forCellWithReuseIdentifier:[cellClass reuseID]];
        }
        else
        {
            [self registerClass:[cellClass class] forCellWithReuseIdentifier:[cellClass reuseID]];
        }
    }
}

- (void)nsf_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind
{
    if ([viewClass isSubclassOfClass:[UICollectionReusableView class]])
    {
        NSString *nibName = NSStringFromClass(viewClass);
        if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
        {
            [self registerNib:[viewClass nsf_nib] forSupplementaryViewOfKind:elementKind withReuseIdentifier:[viewClass reuseID]];
        }
        else
        {
            [self registerClass:[viewClass class] forSupplementaryViewOfKind:elementKind withReuseIdentifier:[viewClass reuseID]];
        }
    }
}

#pragma mark - Property
- (NSIndexPath *)nsf_nestedIndexPath
{
    return objc_getAssociatedObject(self, @selector(nsf_nestedIndexPath));
}

- (void)nsf_setNestedIndexPath:(NSIndexPath *)nsf_nestedIndexPath
{
    objc_setAssociatedObject(self, @selector(nsf_nestedIndexPath), nsf_nestedIndexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
