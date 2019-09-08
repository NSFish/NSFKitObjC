//
//  ForegroundView.m
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/26.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import "ForegroundView.h"
#import <Masonry.h>

@interface ForegroundView()
@property (nonatomic, strong) UILabel *label;

@end


@implementation ForegroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.label = [UILabel new];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 15, 0, 0));
        }];
    }
    
    return self;
}

@end
