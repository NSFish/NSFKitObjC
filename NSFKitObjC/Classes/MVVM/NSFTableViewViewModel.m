//
//  NSFTableViewViewModel.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFTableViewViewModel.h"

@implementation NSFTableViewViewModel

#pragma mark - NSFTableViewViewModel
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (id)tv_cellViewModel4RowAtIndexPath:(NSIndexPath *)indexPath
{
    // 默认情况下 cell 就直接使用 model 了
    return [self tv_model4RowAtIndexPath:indexPath];
}

@end
