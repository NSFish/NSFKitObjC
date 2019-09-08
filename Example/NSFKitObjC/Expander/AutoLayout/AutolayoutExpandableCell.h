//
//  AutolayoutExpandableCell.h
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/26.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForegroundView.h"
#import "ExpandableView.h"
#import "NSFTableViewCellExpandable.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutolayoutExpandableCell : UITableViewCell<NSFTableViewCellExpandable>
@property (readonly) ForegroundView *foregroundView;
@property (readonly) ExpandableView *expandableView;

@end

NS_ASSUME_NONNULL_END
