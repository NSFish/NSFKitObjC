//
//  AutolayoutExpandableCell.m
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/26.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import "AutolayoutExpandableCell.h"
#import "NSFTableViewCellExpander.h"
@import Masonry;

@interface AutolayoutExpandableCell ()
@property (nonatomic, strong) ForegroundView *foregroundView;
@property (nonatomic, strong) ExpandableView *expandableView;

@end


@implementation AutolayoutExpandableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.foregroundView = [ForegroundView new];
        self.foregroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.foregroundView];
        [self.foregroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).priorityHigh();
            make.height.equalTo(@44);
        }];
        
        self.expandableView = [ExpandableView new];
        self.expandableView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.expandableView];
        [self.expandableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.foregroundView.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).priorityHigh();
        }];
    }
    
    return self;
}

#pragma mark - NSFTableViewCellFoldable
- (void)configWithExpandState:(BOOL)expand
{
    if (expand)
    {
        [self.expandableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
        }];
    }
    else
    {
        [self.expandableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

@end
