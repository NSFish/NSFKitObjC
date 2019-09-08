//
//  NSFViewController.m
//  NSFKitObjC
//
//  Created by NSFish on 11/01/2018.
//  Copyright (c) 2018 NSFish. All rights reserved.
//

#import "NSFViewController.h"
#import "ExpandableViewController.h"
#import "UIViewControllerDefaultInitialization.h"
@import ReactiveObjC;

@interface NSFViewController ()
@property (nonatomic, copy, readonly) Array(RACTuple) dataSource;

@end


@implementation NSFViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        self.title = @"Example";
        _dataSource =
        @[RACTuplePack(@"Expandable Cell", NSStringFromClass([ExpandableViewController class]))];
    }
    
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;    
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
