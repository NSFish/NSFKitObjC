//
//  NSFLoadingIndicator.h
//  AWSCore
//
//  Created by shlexingyu on 2019/3/21.
//

#import <NSFLoadingIndicatorProtocol.h>
#import "NSFLoadingIndicatorContentViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFLoadingIndicator : UIView

+ (id<NSFLoadingIndicator>)loadingIndicator;

+ (void)showGlobalLoadingIndicator;
+ (void)hideGlobalLoadingIndicator;

@end

NS_ASSUME_NONNULL_END
