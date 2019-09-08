//
//  NSFTableViewCellExpandable.h
//  AWSCore
//
//  Created by shlexingyu on 2019/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFTableViewCellExpandable <NSObject>

- (void)configWithExpandState:(BOOL)expand;

@end

NS_ASSUME_NONNULL_END
