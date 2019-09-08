//
//  NSArray+NSFExt.h
//  AWSCore
//
//  Created by shlexingyu on 2019/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (NSFExt)

- (nullable ObjectType)nsf_safeObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
