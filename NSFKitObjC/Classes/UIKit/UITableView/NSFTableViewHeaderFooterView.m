//
//  NSFTableViewHeaderFooterView.m
//  TQMall
//
//  Created by NSFish on 2018/10/24.
//  Copyright © 2018年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import "NSFTableViewHeaderFooterView.h"
#import "UIGestureRecognizer+NSFExt.h"

@interface NSFTableViewHeaderFooterView ()
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end


@implementation NSFTableViewHeaderFooterView
@synthesize nsf_accessoryView = _nsf_accessoryView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        // 默认情况下 backgroundView 为 nil，UITableViewHeaderFooterView 会自行添加一个 _UITableViewHeaderFooterViewBackground 作为最下层的 subview，导致设置
        // self.backgroundColor 和 self.backgroundView.backgroundColor 均无效
        self.backgroundView = [UIView new];

        __weak typeof(self) weakSelf = self;
        self.tap = [UITapGestureRecognizer gestureRecognizerWithBlock:^(UIGestureRecognizer *gesture) {
            typeof(self) self = weakSelf;
            
            !self.contentViewTapped ?: self.contentViewTapped();
        }];
        [self.contentView addGestureRecognizer:self.tap];
        
        // 当外部指定 contentViewTapped 时才 enable
        self.tap.enabled = NO;
    }
    
    return self;
}

#pragma mark - Property
- (UIView *)nsf_accessoryView
{
    return _nsf_accessoryView;
}

- (void)nsf_setAccessoryView:(UIView *)accessoryView
{
    if (_nsf_accessoryView)
    {
        [_nsf_accessoryView removeFromSuperview];
    }
    
    _nsf_accessoryView = accessoryView;
    [self addSubview:_nsf_accessoryView];
}

- (void)setContentViewTapped:(dispatch_block_t)contentViewTapped
{
    _contentViewTapped = contentViewTapped;
    
    self.tap.enabled = (_contentViewTapped != nil);
}

#pragma mark - Override
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.nsf_accessoryView)
    {
        CGRect frame = self.contentView.frame;
        frame.size.width = self.bounds.size.width - self.nsf_accessoryView.bounds.size.width - 15;
        self.contentView.frame = frame;
        
        self.nsf_accessoryView.frame = CGRectMake(self.bounds.size.width - 15 - self.nsf_accessoryView.frame.size.width,
                                                 (self.bounds.size.height - self.nsf_accessoryView.frame.size.height) / 2,
                                                 self.nsf_accessoryView.frame.size.width,
                                                 self.nsf_accessoryView.frame.size.height);
    }
    else
    {
        CGRect frame = self.contentView.frame;
        frame.size.width = self.bounds.size.width;
        self.contentView.frame = frame;
    }
    
    if (self.nsf_textLabelFont)
    {
        self.textLabel.font = self.nsf_textLabelFont;
    }
    
    if (self.nsf_textLabelColor)
    {
        self.textLabel.textColor = self.nsf_textLabelColor;
    }
    
    if (self.textLabelX > 0)
    {
        CGRect frame = self.textLabel.frame;
        frame.origin.x = self.textLabelX;
        self.textLabel.frame = frame;
    }
}

#pragma mark - Bug fix
/**
 从 iOS 9 开始，在某些情况下 UITableViewHeaderFooterView 的 width 会变成 0，导致 Autolayout 报错。
 这里做个简单的过滤，详见
 https://stackoverflow.com/a/35053234/2135264
 */
- (void)setFrame:(CGRect)frame
{
    if (frame.size.width == 0)
    {
        return;
    }
    
    [super setFrame:frame];
}

@end
