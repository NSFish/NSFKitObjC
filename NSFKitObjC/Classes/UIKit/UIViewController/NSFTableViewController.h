//
//  NSFTableViewController.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFContentViewController.h"
#import "NSFTableViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFTableViewController : NSFContentViewController<NSFAllOptionalTableViewDataSource, UITableViewDelegate>
@property (readonly) UITableView *tableView;
@property (readonly) NSError *refreshError;

/**
 是否允许用户在 loading 时进行交互，默认为 YES
 */
@property (nonatomic, assign) BOOL allowUserInterectionWhileLoading;

/**
 是否在加载数据时显示 loading indicator，默认为 YES. 若子类中要展示的数据是从本地缓存中读取，可以设置为 NO，避免 loading indicator 一闪而过
 */
@property (nonatomic, assign) BOOL showLoadingIndicatorWhileLoading;

/**
 是否在从下一级页面返回到 tableViewController 时才 deselectRow，默认为 YES
 */
@property (nonatomic, assign) BOOL clearsSelectionOnViewWillAppear;

/**
 是否由外部来决定 tableView 的布局约束，一般由 subclass 设置，默认为 NO. 需在 viewDidLoad 之前设置.
 */
@property (nonatomic, assign) BOOL customTableViewAutoLayout;

/**
 是否支持下拉刷新，默认为 NO
 */
@property (nonatomic, assign) BOOL supportPullToRefresh;

/**
 统一设置 cell.separatorInsetd，默认值为 (0, 15, 0, 0). 若不同 cell 需要不同的缩进，则应用 separatorInsetForRowAtIndexPath:
 */
@property (nonatomic, assign) UIEdgeInsets separatorInset;

#pragma mark - Overridable
/**
 分隔线缩进，兼容 layoutMargins

 @param indexPath indexPath
 @return 默认返回 self.separatorInset
 */
- (UIEdgeInsets)separatorInsetForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)refresh NS_REQUIRES_SUPER;

/**
 默认情况下 tableView.tableFooterView = [UIView new]，用于移除没有数据时的分隔线
 若子类需要在有数据时显示自定义的 tableFooterView，override 此方法并返回即可
 */
- (UIView *)customTableFooterView;

#pragma mark - Init
- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithStyle:(UITableViewStyle)style
                    viewModel:(id<NSFTableViewViewModel>)viewModel NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
