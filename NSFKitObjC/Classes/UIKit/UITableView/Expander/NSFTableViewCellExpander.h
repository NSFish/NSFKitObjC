//
//  NSFTableViewCellExpander.h
//  AWSCore
//
//  Created by shlexingyu on 2019/3/27.
//

#import <Foundation/Foundation.h>
#import "NSFTableViewCellExpandable.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFTableViewCellExpander : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView
                    useAutoLayout:(BOOL)useAutoLayout NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - Public
- (BOOL)expandStateForCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)configCell:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell withExpandStateAtIndexPath:(NSIndexPath *)indexPath;

- (void)changeExpandState:(__kindof UITableViewCell<NSFTableViewCellExpandable> *)cell;

@end

NS_ASSUME_NONNULL_END
