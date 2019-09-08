//
//  UIKitReusableComponent.h
//  TQMall
//
//  Created by NSFish on 2018/10/18.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFReusableUIComponent<NSObject>

+ (NSString *)reuseID;

@end

NS_ASSUME_NONNULL_END
