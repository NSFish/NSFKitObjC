//
//  UICollectionReusableView+NSFExt.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/15.
//

#import "UICollectionReusableView+NSFExt.h"

@implementation UICollectionReusableView (NSFExt)

+ (NSString *)reuseID
{
    return NSStringFromClass([self class]);
}

@end
