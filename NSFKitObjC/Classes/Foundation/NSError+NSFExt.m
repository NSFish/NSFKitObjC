//
//  NSError+NSFExt.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/27.
//

#import "NSError+NSFExt.h"

NSString* nsf_valueWithDefault(NSString *value)
{
    return value ? value : @"";
}

static NSString *g_userDomain = @"";

@implementation NSError (NSFExt)

#pragma mark - Init
+ (instancetype)errorWithCode:(NSInteger)code
                     msg2User:(NSString *)msg2User
{
    NSDictionary *userInfo = @{NSStringFromSelector(@selector(msg2User)): nsf_valueWithDefault(msg2User)};
    return [NSError errorWithDomain:g_userDomain code:code userInfo:userInfo];
}

#pragma mark - Public
+ (void)nsf_setErrorDomain:(NSString *)domain
{
    g_userDomain = domain;
}

#pragma mark - Property
- (void)setCode:(NSInteger)code
{
    // 不用 "code" 防止直接查找setCode导致死循环
    [self setValue:@(code) forKey:@"_code"];
}

- (NSFErrorMsgDisplayType)displayType
{
    return [self.userInfo[NSStringFromSelector(_cmd)] integerValue];
}

- (void)setDisplayType:(NSFErrorMsgDisplayType)displayType
{
    [self nsf_setUserInfoWithKey:NSStringFromSelector(@selector(displayType)) value:@(displayType)];
}

- (NSString *)msg2User
{
    return self.userInfo[NSStringFromSelector(_cmd)];
}

- (void)setMsg2User:(NSString *)msg2User
{
    [self nsf_setUserInfoWithKey:NSStringFromSelector(@selector(msg2User)) value:msg2User];
}

#pragma mark - Private
- (void)nsf_setUserInfoWithKey:(NSString *)key value:(id)value
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:self.userInfo];
    userInfo[key] = nsf_valueWithDefault(value);
    [self setValue:userInfo forKey:@"userInfo"];
}

@end
