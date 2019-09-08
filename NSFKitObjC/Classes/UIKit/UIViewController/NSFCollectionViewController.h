//
//  NSFCollectionViewController.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFContentViewController.h"
#import "NSFCollectionViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFCollectionViewController : NSFContentViewController<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate>
@property (readonly) UICollectionView *collectionView;
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
 是否由外部来决定 collectionView 的布局约束，一般由 subclass 设置，默认为 NO. 需在 viewDidLoad 之前设置.
 */
@property (nonatomic, assign) BOOL customCollectionViewAutoLayout;

- (instancetype)initWithLayout:(nullable UICollectionViewLayout *)layout
                     viewModel:(nullable id<NSFCollectionViewViewModel>)viewModel NS_DESIGNATED_INITIALIZER;

#pragma mark - Overridable
- (void)refresh NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
