//
//  FrameBasedExpandableCell.h
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/27.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForegroundView.h"
#import "ExpandableView.h"
#import "NSFTableViewCellExpandable.h"

NS_ASSUME_NONNULL_BEGIN

@interface FrameBasedExpandableCell : UITableViewCell<NSFTableViewCellExpandable>
@property (readonly) ForegroundView *foregroundView;
@property (readonly) ExpandableView *expandableView;

+ (CGFloat)heightWithExpandState:(BOOL)expand;

@end

NS_ASSUME_NONNULL_END
