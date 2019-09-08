//
//  NSFTableViewController.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFTableViewController.h"
#import "NSFTableViewDelegateProxy.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface NSFTableViewController ()
@property (nonatomic, assign, readonly) UITableViewStyle style;
@property (nonatomic, strong, readonly) id<NSFTableViewViewModel> tvViewModel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFTableViewDelegateProxy *tableViewDelegate;
@property (nonatomic, copy)   NSError *refreshError;

@end


@implementation NSFTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init])
    {
        _style = style;
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
                    viewModel:(id<NSFTableViewViewModel>)viewModel
{
    if (self = [super init])
    {
        _style = style;
        _tvViewModel = viewModel;
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);

    self.allowUserInterectionWhileLoading = YES;
    self.showLoadingIndicatorWhileLoading = YES;
    self.clearsSelectionOnViewWillAppear = YES;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 将 tableView 作为 self.view 的 subview 而不是其本身, 以支持子类对 tableView 的约束进行修改
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    
    if (self.tvViewModel)
    {
        self.tableViewDelegate = [[NSFTableViewDelegateProxy alloc] initWithViewController:self viewModel:self.tvViewModel];
        self.tableView.dataSource = self.tableViewDelegate;
        self.tableView.delegate = self.tableViewDelegate;
    }
    else
    {
        self.tableView.dataSource = (UIViewController<UITableViewDataSource> *)self;
        self.tableView.delegate = self;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *))
    {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:self.tableView];
    
    if (!self.customTableViewAutoLayout)
    {
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *left = [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        NSLayoutConstraint *top = [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
        NSLayoutConstraint *bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
    }
    
    @weakify(self);
    [RACObserve(self, supportPullToRefresh) subscribeNext:^(NSNumber *supportPullToRefresh) {
        @strongify(self);
        
        if (supportPullToRefresh.boolValue)
        {
            if (!self.refreshControl)
            {
                self.refreshControl = [UIRefreshControl new];
                [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
                [self.tableView addSubview:self.refreshControl];
            }
        }
        else
        {
            [self.refreshControl endRefreshing];
            [self.refreshControl removeFromSuperview];
            self.refreshControl = nil;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.clearsSelectionOnViewWillAppear)
    {
        [self smoothlyDeselectRowsInTableView:self.tableView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 保证 tableViewController 存在于自定义容器中时也总是能 scrollsToTop, 下同
    self.tableView.scrollsToTop = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.tableView.scrollsToTop = NO;
}

#pragma mark - Request
- (void)refresh
{
    if (!self.tvViewModel)
    {
        return;
    }
    
    self.state = NSFContentViewControllerStateLoading;
    self.refreshError = nil;
    self.tableView.tableFooterView = [UIView new];
    
    if ([self.tableView.dataSource numberOfSectionsInTableView:self.tableView] == 0
        && !self.refreshControl.refreshing)
    {
        [self showLoadingIndicator];
    }
    
    @weakify(self);
    [[[self.tvViewModel tv_refreshSignal] finally:^{
        @strongify(self);

        [self.refreshControl endRefreshing];
        [self hideLoadingIndicator];
    }] subscribeNext:^(NSNumber *count) {
        @strongify(self);
        
        [self.tableView reloadData];
        
        // 无数据时通常要隐藏 tableFooterView
        if (count.integerValue == 0)
        {
            self.tableView.tableFooterView = [UIView new];
        }
        else
        {
            self.tableView.tableFooterView = [self customTableFooterView];
        }
    } error:^(NSError *error) {
        @strongify(self);

        self.refreshError = error;
        self.state = NSFContentViewControllerStateFailed;
        [self.tableView reloadData];
    } completed:^{
        @strongify(self);
        
        // 考虑到可能不止一次 sendNext，在 completed 时才设置为 success
        self.state = NSFContentViewControllerStateSuccess;
        [self.tableView reloadData];
    }];
    
    [self.tableView reloadData]; // 刷掉可能显示的空白提示页
}

#pragma mark - Override
- (void)showLoadingIndicatorInView:(UIView *)view
{
    if (self.showLoadingIndicatorWhileLoading)
    {
        [super showLoadingIndicatorInView:view];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 移除 iPad 上的留白
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    // 阻止 Cell 继承来自 TableView 相关的设置(LayoutMargins or SeparatorInset)
    // 使 Cell 独立地设置其自身的分割线边距而不依赖于 TableView
    cell.preservesSuperviewLayoutMargins = NO;
    
    // layoutMargins 默认为 (0, 8, 0, 8). iOS 10 之前，separatorInset 的值小于 layoutMargins 时无效.
    // https://stackoverflow.com/a/26827362/2135264
    cell.layoutMargins = UIEdgeInsetsZero;
    
    cell.separatorInset = [self separatorInsetForRowAtIndexPath:indexPath];
}

- (UIEdgeInsets)separatorInsetForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.separatorInset;
}

- (__kindof UIView *)customTableFooterView
{
    return [UIView new];
}

#pragma mark - Private
- (void)smoothlyDeselectRowsInTableView:(UITableView *)tableView
{
    // https://www.raizlabs.com/dev/2016/05/smarter-animated-row-deselection-ios/
    NSArray<NSIndexPath *> *selectedIndexPaths = [tableView indexPathsForSelectedRows];
    if (self.transitionCoordinator)
    {
        [self.transitionCoordinator
         animateAlongsideTransitionInView:self.parentViewController.view
         animation:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
             for (NSIndexPath *indexPath in selectedIndexPaths)
             {
                 UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                 if (!cell.editing)
                 {
                     [tableView deselectRowAtIndexPath:indexPath animated:context.isAnimated];
                 }
             }
         } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
             if (context.isCancelled)
             {
                 for (NSIndexPath *indexPath in selectedIndexPaths)
                 {
                     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                     if (!cell.editing)
                     {
                         [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                     }
                 }
             }
         }];
    }
    else
    {
        for (NSIndexPath *indexPath in selectedIndexPaths)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
}


@end
