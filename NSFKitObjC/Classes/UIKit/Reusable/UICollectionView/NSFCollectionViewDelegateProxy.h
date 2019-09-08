//
//  NSFCollectionViewDelegateProxy.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/16.
//

#import "NSFPrioritizedDelegate.h"
#import "NSFCollectionViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 将 UICollectionView.dataSource/delegate 的方法调用转发给传入的 viewModel 或 VC
 */
@interface NSFCollectionViewDelegateProxy : NSFPrioritizedDelegate<UICollectionViewDataSource, UICollectionViewDelegate>

- (instancetype)initWithViewController:(UIViewController<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate> *)viewController
                             viewModel:(id<NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate>)viewModel NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
