//
//  UITableViewCell+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/11.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "UITableViewCell+NSFExt.h"

@implementation UITableViewCell (NSFExt)

+ (NSString *)reuseID
{
    return NSStringFromClass([self class]);
}

@end


@implementation UITableViewHeaderFooterView (NSFExt)

+ (NSString *)reuseID
{
    return NSStringFromClass([self class]);
}

@end
