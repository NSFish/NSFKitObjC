//
//  NSFLabel.m
//  NSFKitObjC
//
//  Created by shlexingyu on 2019/1/15.
//

#import "NSFLabel.h"
#import "NSObject+NSFExt.h"
#include "NSFLightweightGenericSupport.h"

static NSArray *NSFLabelAutoAttributedPropertyNames() {
    static NSArray<NSString *> *propertyNames = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        propertyNames = @[@"font",
                          @"text",
                          @"textColor",
                          @"textAlignment",
                          @"lineBreakMode",
                          @"numberOfLines",
                          @"baselineAdjustment",
                          @"nsf_lineHeight"];
    });
    
    return propertyNames;
}


@interface NSFLabel ()
@property (nonatomic, copy) NSAttributedString *cachedInputAttributedString;

@end


@implementation NSFLabel

- (void)dealloc
{
    for (NSString *key in NSFLabelAutoAttributedPropertyNames())
    {
        [self removeObserver:self forKeyPath:key context:nil];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        for (NSString *key in NSFLabelAutoAttributedPropertyNames())
        {
            [self addObserver:self
                   forKeyPath:key
                      options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                      context:nil];
        }
    }
    
    return self;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([NSFLabelAutoAttributedPropertyNames() containsObject:keyPath])
    {
        id old = change[NSKeyValueChangeOldKey];
        id new = change[NSKeyValueChangeNewKey];
        if ([old isEqual:new] || (!old && !new))
        {
            return;
        }
        
        [self _refreshIfNeeded];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Private
- (void)_refreshIfNeeded
{
    if (!self.attributedText)
    {
        return;
    }
    
    self.attributedText = self.attributedText;
}

- (NSAttributedString *)_adjustLineHeightAndBaselineOffset:(NSAttributedString *)attributedText
{
    if (!attributedText)
    {
        return nil;
    }
    
    NSMutableAttributedString *mText = [attributedText mutableCopy];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle safelyCast:[attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil]];
    if (!paragraphStyle)
    {
        paragraphStyle = [NSMutableParagraphStyle new];
    }
    
    if (self.nsf_lineHeight > 0)
    {
        paragraphStyle.maximumLineHeight = self.nsf_lineHeight;
        paragraphStyle.minimumLineHeight = self.nsf_lineHeight;
        
        MArray(UIFont) fonts = [NSMutableArray new];
        [attributedText enumerateAttribute:NSFontAttributeName
                                   inRange:NSMakeRange(0, attributedText.length)
                                   options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                usingBlock:^(UIFont *font, NSRange range, BOOL *stop) {
                                    if (font)
                                    {
                                        [fonts addObject:font];
                                    }
        }];
        
        CGFloat baselineOffsetHack = 0;
        if (fonts.count > 1)
        {
            baselineOffsetHack = 1;
        }
        
        [attributedText enumerateAttributesInRange:NSMakeRange(0, attributedText.length)
                                           options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                        usingBlock:^(NSDictionary<NSAttributedStringKey,id> *attrs, NSRange range, BOOL *stop) {
                                            if (attrs.allKeys.count == 0)
                                            {
                                                return;
                                            }
                                            
                                            NSNumber *baselineOffset = attrs[NSBaselineOffsetAttributeName];
                                            if (!baselineOffset)
                                            {
                                                UIFont *font = attrs[NSFontAttributeName];
                                                if (font)
                                                {
                                                    CGFloat offset = (self.nsf_lineHeight - font.lineHeight) / 4;
                                                    [mText addAttribute:NSBaselineOffsetAttributeName
                                                                  value:@(offset)
                                                                  range:range];
                                                }
                                            }
                                        }];
    }
    [mText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mText.length)];
    
    return [mText copy];
}

#pragma mark - Override
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:[self _adjustLineHeightAndBaselineOffset:attributedText]];
}

#pragma mark - Public
+ (NSArray<NSString *> *)defaultAutoAdjustedPropertyNames
{
    return NSFLabelAutoAttributedPropertyNames();
}

@end
