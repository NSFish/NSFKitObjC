//
//  FrameBasedExpandableCell.m
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/27.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import "FrameBasedExpandableCell.h"

static const CGFloat kViewHeight = 44;

@interface FrameBasedExpandableCell ()
@property (nonatomic, strong) ForegroundView *foregroundView;
@property (nonatomic, strong) ExpandableView *expandableView;

@end


@implementation FrameBasedExpandableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.foregroundView = [[ForegroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kViewHeight)];
        self.foregroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.foregroundView];
        
        self.expandableView = [[ExpandableView alloc] initWithFrame:CGRectMake(0, kViewHeight, [UIScreen mainScreen].bounds.size.width, 0)];
        self.expandableView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.expandableView];
    }
    
    return self;
}

#pragma mark - Public
+ (CGFloat)heightWithExpandState:(BOOL)expand
{
    return expand ? kViewHeight * 2 : kViewHeight;
}

#pragma mark - NSFTableViewCellFoldable
- (void)configWithExpandState:(BOOL)expand
{
    if (expand)
    {
        CGRect frame = self.expandableView.frame;
        frame.size.height = kViewHeight;
        self.expandableView.frame = frame;
    }
    else
    {
        CGRect frame = self.expandableView.frame;
        frame.size.height = 0;
        self.expandableView.frame = frame;
    }
}

@end
