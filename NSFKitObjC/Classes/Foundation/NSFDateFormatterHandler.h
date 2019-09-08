//
//  NSFDateFormatterHandler.h
//  TQMall
//
//  Created by shlexingyu on 2019/3/14.
//  Copyright © 2019年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFDateFormatterHandler : NSObject

+ (NSString *)humanReadableDateStringFromDate:(NSDate *)date
                                withDateStyle:(NSDateFormatterStyle)dateStyle
                                    timeStyle:(NSDateFormatterStyle)timeStyle;

+ (NSString *)humanReadableDateStringFromDate:(NSDate *)date
                                 WithTemplate:(NSString *)dateTemplate;

@end


@interface NSDate(NSFFormat)

- (NSString *)humanReadableDateStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                         timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)humanReadableDateStringWithDateTemplate:(NSString *)dateTemplate;

@end

NS_ASSUME_NONNULL_END
