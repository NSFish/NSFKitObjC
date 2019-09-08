//
//  NSFDateFormatterHandler.m
//  TQMall
//
//  Created by shlexingyu on 2019/3/14.
//  Copyright © 2019年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFDateFormatterHandler.h"

@interface NSFDateFormatterHandler ()
@property (nonatomic, strong) NSDateFormatter *styleDateFormatter;
@property (nonatomic, strong) NSDateFormatter *formatDateFormatter;

@end


@implementation NSFDateFormatterHandler

+ (instancetype)sharedIntance
{
    static NSFDateFormatterHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [NSFDateFormatterHandler new];
    });
    
    return handler;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(resetDateFormatters)
                                   name:NSCurrentLocaleDidChangeNotification
                                 object:nil];
        
        [self resetDateFormatters];
    }
    
    return self;
}

- (void)resetDateFormatters
{
    @synchronized (self) {
        self.styleDateFormatter = [NSDateFormatter new];
        self.formatDateFormatter = [NSDateFormatter new];
    }
}

+ (NSString *)humanReadableDateStringFromDate:(NSDate *)date withDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [[NSFDateFormatterHandler sharedIntance] humanReadableDateStringFromDate:date withDateStyle:dateStyle timeStyle:timeStyle];
}

+ (NSString *)humanReadableDateStringFromDate:(NSDate *)date WithTemplate:(NSString *)dateTemplate
{
    return [[NSFDateFormatterHandler sharedIntance] humanReadableDateStringFromDate:date WithTemplate:dateTemplate];
}

- (NSString *)humanReadableDateStringFromDate:(NSDate *)date
                                withDateStyle:(NSDateFormatterStyle)dateStyle
                                    timeStyle:(NSDateFormatterStyle)timeStyle
{
    @synchronized (self) {
        [self.styleDateFormatter setLocale:[self locale]];
        [self.styleDateFormatter setDateStyle:dateStyle];
        [self.styleDateFormatter setTimeStyle:timeStyle];
        
        return [self.styleDateFormatter stringFromDate:date];
    }
}

- (NSString *)humanReadableDateStringFromDate:(NSDate *)date WithTemplate:(NSString *)dateTemplate
{
    @synchronized (self) {
        [self.styleDateFormatter setLocale:[self locale]];
        NSString *format = [NSDateFormatter dateFormatFromTemplate:dateTemplate options:0 locale:[self locale]];
        self.formatDateFormatter.dateFormat = format;
        
        return [self.formatDateFormatter stringFromDate:date];
    }
}

- (NSLocale *)locale
{
    return [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
}

@end


@implementation NSDate(NSFFormat)

- (NSString *)humanReadableDateStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                         timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [NSFDateFormatterHandler humanReadableDateStringFromDate:self
                                                     withDateStyle:dateStyle
                                                         timeStyle:timeStyle];
}

- (NSString *)humanReadableDateStringWithDateTemplate:(NSString *)dateTemplate
{
    return [NSFDateFormatterHandler humanReadableDateStringFromDate:self
                                                      WithTemplate:dateTemplate];
}

@end
