//
//  NSFLabel.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFLabel : UILabel

@property (nonatomic, assign) CGFloat nsf_lineHeight;

/**
 支持设置行高的属性列表
 */
+ (NSArray<NSString *> *)defaultAutoAdjustedPropertyNames;

@end

NS_ASSUME_NONNULL_END
