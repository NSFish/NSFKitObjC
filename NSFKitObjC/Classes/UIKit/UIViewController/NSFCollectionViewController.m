//
//  NSFCollectionViewController.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFCollectionViewController.h"
#import "NSFCollectionViewDelegateProxy.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface NSFCollectionViewController ()
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong, readonly) id<NSFCollectionViewViewModel> cvViewModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSFCollectionViewDelegateProxy *collectionViewDelegate;
@property (nonatomic, copy)   NSError *refreshError;

@end


@implementation NSFCollectionViewController

- (instancetype)init
{
    return [self initWithLayout:nil viewModel:nil];
}

- (instancetype)initWithViewModel:(id<NSFCollectionViewViewModel>)viewModel
{
    return [self initWithViewModel:viewModel];
}

- (instancetype)initWithLayout:(UICollectionViewLayout *)layout
                     viewModel:(id<NSFCollectionViewViewModel>)viewModel
{
    if (self = [super init])
    {
        _layout = layout;
        _cvViewModel = viewModel;
        
        self.allowUserInterectionWhileLoading = YES;
        self.showLoadingIndicatorWhileLoading = YES;
    }
    
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.layout)
    {
        self.layout = [UICollectionViewFlowLayout new];
    }
    
    // 将 collectionView 作为 self.view 的 subview 而不是其本身, 以支持子类对 tableView 的约束进行修改
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    if (self.cvViewModel)
    {
        self.collectionViewDelegate = [[NSFCollectionViewDelegateProxy alloc] initWithViewController:self viewModel:self.cvViewModel];
        self.collectionView.dataSource = self.collectionViewDelegate;
        self.collectionView.delegate = self.collectionViewDelegate;
    }
    else
    {
        self.collectionView.dataSource = (UIViewController<UICollectionViewDataSource> *)self;
        self.collectionView.delegate = self;
    }
    
    [self.view addSubview:self.collectionView];
    
    if (!self.customCollectionViewAutoLayout)
    {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *left = [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *right = [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor];
        NSLayoutConstraint *top = [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor];
        NSLayoutConstraint *bottom = [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
    }
}

#pragma mark - Request
- (void)refresh
{
    if (!self.cvViewModel)
    {
        return;
    }
    
    self.state = NSFContentViewControllerStateLoading;
    self.refreshError = nil;
    
    [self showLoadingIndicator];
    
    @weakify(self);
    [[[self.cvViewModel cv_refreshSignal] finally:^{
        @strongify(self);
        
        [self hideLoadingIndicator];
    }] subscribeNext:^(NSNumber *count) {
        @strongify(self);
        
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        @strongify(self);
        
        self.refreshError = error;
        self.state = NSFContentViewControllerStateFailed;
        [self.collectionView reloadData];
    } completed:^{
        @strongify(self);
        
        // 考虑到可能不止一次 sendNext，在 completed 时才设置为 success
        self.state = NSFContentViewControllerStateSuccess;
        [self.collectionView reloadData];
    }];
    
    [self.collectionView reloadData]; // 刷掉可能显示的空白提示页
}

#pragma mark - Override
- (void)showLoadingIndicatorInView:(UIView *)view
{
    if (self.showLoadingIndicatorWhileLoading)
    {
        [super showLoadingIndicatorInView:view];
    }
}

@end
