//
//  NSFUIComponentRegistration.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/3.
//

#import "NSFUIComponentRegistration.h"

@interface NSFUIComponentRegistration()
@property (nonatomic, strong) NSMutableDictionary<NSString *, Class> *registrations;

@end


@implementation NSFUIComponentRegistration

+ (instancetype)sharedInstance
{
    static NSFUIComponentRegistration *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.registrations = [NSMutableDictionary new];
    }
    
    return self;
}

#pragma mark - Public
+ (void)registerUICompomnent:(Class)componentClass conformTo:(Protocol *)protocol
{
    @synchronized ([NSFUIComponentRegistration sharedInstance].registrations) {
        [NSFUIComponentRegistration sharedInstance].registrations[NSStringFromProtocol(protocol)] = componentClass;
    }
}

+ (void)unregisterUICompomnent:(Class)componentClass conformTo:(Protocol *)protocol
{
    @synchronized ([NSFUIComponentRegistration sharedInstance].registrations) {
        [[NSFUIComponentRegistration sharedInstance].registrations removeObjectForKey:NSStringFromProtocol(protocol)];
    }
}

+ (Class)UIComponent4Protocol:(Protocol *)protocol
{
    Class class = nil;
    @synchronized ([NSFUIComponentRegistration sharedInstance].registrations) {
        class = [NSFUIComponentRegistration sharedInstance].registrations[NSStringFromProtocol(protocol)];
    }
    
    return class;
}

@end
