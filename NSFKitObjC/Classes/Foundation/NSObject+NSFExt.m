//
//  NSObject+NSFExt.m
//  TQMall
//
//  Created by NSFish on 2018/10/15.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSObject+NSFExt.h"
#import <objc/runtime.h>

#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)    \
if (ERROR_VAR) {    \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1    \
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

@implementation NSObject (NSFExt)

+ (instancetype)safelyCast:(id<NSObject>)object
{
    if ([object isKindOfClass:[self class]])
    {
        return object;
    }
    
    return nil;
}

+ (BOOL)nsf_protocol:(Protocol *)protocol declareSelector:(SEL)selector
{
    unsigned int count = 0;
    struct objc_method_description *descriptions = protocol_copyMethodDescriptionList(protocol, YES, YES, &count);
    for (unsigned int i = 0; i < count; ++i)
    {
        if (descriptions[i].name == selector)
        {
            free(descriptions);
            return YES;
        }
    }
    
    free(descriptions);
    
    return NO;
}

#pragma mark - Associated Object
- (nullable id)nsf_associatedObjectForKey:(const void *)key policy:(NSFObjcAssociationPolicy)policy
{
    if (policy == NSFObjcAssociationPolicyWeak)
    {
        return [self nsf_weakAssociatedObjectWithKey:key];
    }
    
    return objc_getAssociatedObject(self, key);
}

- (void)nsf_setAssociatedObject:(id)object withKey:(const void *)key policy:(NSFObjcAssociationPolicy)policy
{
    if (policy == NSFObjcAssociationPolicyWeak)
    {
        [self nsf_setWeakAssociatedObject:object forKey:key];
        return;
    }
    
    objc_AssociationPolicy objcPolicy = [self nsf_systemDefinedPolicyFrom:policy];
    objc_setAssociatedObject(self, key, object, objcPolicy);
}

#pragma mark - Method Swizzling
// https://github.com/rentzsch/jrswizzle
+ (BOOL)nsf_swizzleMethod:(SEL)originalSelector withMethod:(SEL)selector error:(NSError **)error
{
    Method origMethod = class_getInstanceMethod(self, originalSelector);
    if (!origMethod)
    {
        SetNSError(error, @"original method %@ not found for class %@", NSStringFromSelector(originalSelector), [self class]);
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, selector);
    if (!altMethod)
    {
        SetNSError(error, @"alternate method %@ not found for class %@", NSStringFromSelector(selector), [self class]);
        return NO;
    }
    
    class_addMethod(self,
                    originalSelector,
                    class_getMethodImplementation(self, originalSelector),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    selector,
                    class_getMethodImplementation(self, selector),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, selector));
    
    return YES;
}

+ (BOOL)nsf_swizzleClassMethod:(SEL)originalSelector withClassMethod:(SEL)selector error:(NSError **)error
{
    return [object_getClass((id)self) nsf_swizzleMethod:originalSelector withMethod:selector error:error];
}

#pragma mark - Private(弱引用关联对象)
- (objc_AssociationPolicy)nsf_systemDefinedPolicyFrom:(NSFObjcAssociationPolicy)policy
{
    objc_AssociationPolicy objcPolicy;
    switch (policy) {
        case NSFObjcAssociationPolicyAssign:
        {
            objcPolicy = OBJC_ASSOCIATION_ASSIGN;
        }
            break;
        case NSFObjcAssociationPolicyStrong:
        {
            objcPolicy = OBJC_ASSOCIATION_RETAIN_NONATOMIC;
        }
            break;
        case NSFObjcAssociationPolicyWeak:
        case NSFObjcAssociationPolicyCopy:
        {
            objcPolicy = OBJC_ASSOCIATION_COPY_NONATOMIC;
        }
            break;
        default:
            break;
    }

    return objcPolicy;
}

- (id)nsf_weakAssociatedObjectWithKey:(const void *)key
{
    id(^block)(void) = objc_getAssociatedObject(self, key);
    return block ? block() : nil;
}

- (void)nsf_setWeakAssociatedObject:(id)object forKey:(const void *)key
{
    id __weak weakObject = object;
    id(^block)(void) = ^{ return weakObject; };
    objc_setAssociatedObject(self, key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
