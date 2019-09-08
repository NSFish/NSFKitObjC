//
//  UIView+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/18.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UIView+NSFExt.h"

@implementation UIView (NSFExt)

+ (UINib *)nsf_nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
