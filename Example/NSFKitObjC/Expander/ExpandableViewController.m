//
//  ExpandableViewController.m
//  NSFKit_Example
//
//  Created by nsfish on 2019/9/7.
//  Copyright © 2019 NSFish. All rights reserved.
//

#import "ExpandableViewController.h"
#import "FrameBasedTableViewController.h"
#import "AutoLayoutBasedTableViewController.h"
#import "UIViewControllerDefaultInitialization.h"
@import ReactiveObjC;

@interface ExpandableViewController ()
@property (nonatomic, copy, readonly) Array(RACTuple) dataSource;

@end


@implementation ExpandableViewController

#pragma mark - UIViewControllerDefaultInitialization
+ (instancetype)instance
{
    return [[ExpandableViewController alloc] initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        _dataSource =
        @[RACTuplePack(@"Frame based cell expand", NSStringFromClass([FrameBasedTableViewController class])),
          RACTuplePack(@"AutoLayout based cell expand", NSStringFromClass([AutoLayoutBasedTableViewController class]))];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView nsf_registerCell:[UITableViewCell class]];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell reuseID]
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row].first;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RACTupleUnpack(NSString *title, NSString *vcClassName) = self.dataSource[indexPath.row];
    
    Class<UIViewControllerDefaultInitialization> vcClass = NSClassFromString(vcClassName);
    UIViewController *vc = [vcClass instance];
    vc.title = title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
