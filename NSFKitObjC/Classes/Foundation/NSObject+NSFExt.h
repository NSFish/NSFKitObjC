//
//  NSObject+NSFExt.h
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NSFObjcAssociationPolicy) {
    NSFObjcAssociationPolicyAssign,
    NSFObjcAssociationPolicyStrong,
    NSFObjcAssociationPolicyWeak,
    NSFObjcAssociationPolicyCopy
};

@interface NSObject (NSFExt)

+ (instancetype)safelyCast:(id<NSObject>)object;

+ (BOOL)nsf_protocol:(Protocol *)protocol declareSelector:(SEL)selector;

#pragma mark - Associated Object
- (nullable id)nsf_associatedObjectForKey:(const void *)key policy:(NSFObjcAssociationPolicy)policy;
- (void)nsf_setAssociatedObject:(id)object withKey:(const void *)key policy:(NSFObjcAssociationPolicy)policy;

#pragma mark - Method Swizzling
+ (BOOL)nsf_swizzleMethod:(SEL)originalSelector withMethod:(SEL)selector error:(NSError **)error;
+ (BOOL)nsf_swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)selector error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
