//
//  NSFNavigationBarViewModelProtocol.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFNavigationBarViewModel <NSObject>
@optional

/**
 如果 title 来自于 model，则要从 viewModel 中传出，支持 KVO
 */
@property (copy, nullable, readonly) NSString *title;

@end

NS_ASSUME_NONNULL_END
