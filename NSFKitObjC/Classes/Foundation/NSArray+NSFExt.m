//
//  NSArray+NSFExt.m
//  AWSCore
//
//  Created by shlexingyu on 2019/3/22.
//

#import "NSArray+NSFExt.h"

@implementation NSArray (NSFExt)

- (id)nsf_safeObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    
    return [self objectAtIndex:index];
}

@end
