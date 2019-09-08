//
//  AutoLayoutBasedTableViewController.m
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/25.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import "AutoLayoutBasedTableViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "NSFTableViewCellExpander.h"
#import "AutolayoutExpandableCell.h"
@import Masonry;
@import ReactiveObjC;
@import NSFKitObjC;

@interface AutoLayoutBasedTableViewController ()
@property (nonatomic, strong) NSFTableViewCellExpander *expander;

@end


@implementation AutoLayoutBasedTableViewController

#pragma mark - UIViewControllerDefaultInitialization
+ (instancetype)instance
{
    return [[AutoLayoutBasedTableViewController alloc] initWithStyle:UITableViewStylePlain];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView nsf_registerCell:[AutolayoutExpandableCell class]];
    self.tableView.separatorColor = [UIColor grayColor];
    [self.tableView nsf_disableEstimatedHeight];
    self.expander = [[NSFTableViewCellExpander alloc] initWithTableView:self.tableView];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    return [tableView fd_heightForCellWithIdentifier:[AutolayoutExpandableCell reuseID]
                                       configuration:^(AutolayoutExpandableCell *cell) {
                                           @strongify(self);
                                           
                                           BOOL fold = [self.expander expandStateForCellAtIndexPath:indexPath];
                                           [cell configWithExpandState:fold];
                                       }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutolayoutExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:[AutolayoutExpandableCell reuseID]
                                                                     forIndexPath:indexPath];
    cell.foregroundView.label.text = @(indexPath.row).stringValue;
    [self.expander configCell:cell withExpandStateAtIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.expander changeExpandState:[tableView cellForRowAtIndexPath:indexPath]];
}

@end
