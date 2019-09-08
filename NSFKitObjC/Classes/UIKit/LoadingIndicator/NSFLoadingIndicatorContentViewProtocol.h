//
//  NSFLoadingIndicatorContentViewProtocol.h
//  AWSCore
//
//  Created by shlexingyu on 2019/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFLoadingIndicatorContentView <NSObject>

+ (__kindof UIView *)instance;

- (void)willAppear;
- (void)didAppear;
- (void)willDisappear;
- (void)didDisappear;

@end

NS_ASSUME_NONNULL_END
