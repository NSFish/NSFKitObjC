//
//  FrameBasedTableViewController.m
//  TableViewTest
//
//  Created by shlexingyu on 2019/3/26.
//  Copyright © 2019年 NSFish. All rights reserved.
//

#import "FrameBasedTableViewController.h"
#import "NSFTableViewCellExpander.h"
#import "FrameBasedExpandableCell.h"
@import NSFKitObjC;

@interface FrameBasedTableViewController ()
@property (nonatomic, strong) NSFTableViewCellExpander *expander;

@end


@implementation FrameBasedTableViewController

#pragma mark - UIViewControllerDefaultInitialization
+ (instancetype)instance
{
    return [[FrameBasedTableViewController alloc] initWithStyle:UITableViewStylePlain];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView nsf_registerCell:[FrameBasedExpandableCell class]];
    self.tableView.separatorColor = [UIColor grayColor];
    [self.tableView nsf_disableEstimatedHeight];
    self.expander = [[NSFTableViewCellExpander alloc] initWithTableView:self.tableView];
    
    self.expander = [[NSFTableViewCellExpander alloc] initWithTableView:self.tableView useAutoLayout:NO];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FrameBasedExpandableCell heightWithExpandState:[self.expander expandStateForCellAtIndexPath:indexPath]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FrameBasedExpandableCell *cell = [tableView dequeueReusableCellWithIdentifier:[FrameBasedExpandableCell reuseID]
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
