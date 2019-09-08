//
//  NSError+NSFExt.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NSFErrorMsgDisplayType)
{
    NSFErrorMsgDisplayTypeNone,
    NSFErrorMsgDisplayTypeAlert,
    NSFErrorMsgDisplayTypeHUD
};

@interface NSError (NSFExt)
@property (nonatomic, assign) NSFErrorMsgDisplayType displayType;
@property (nonatomic, copy, nullable) NSString *msg2User;

+ (instancetype)errorWithCode:(NSInteger)code
                       msg2User:(nullable NSString *)msg2User;

- (void)setCode:(NSInteger)code;

+ (void)nsf_setErrorDomain:(NSString *)domain;

@end

NS_ASSUME_NONNULL_END
