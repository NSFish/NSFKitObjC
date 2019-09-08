//
//  NSFCollectionViewViewModelProtocol.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/15.
//

#import "NSFBaseViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class RACSignal, RACSubject;

@protocol NSFAllOptionalCollectionViewDataSource <NSObject>
@optional

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;
- (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView;
- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end


@protocol NSFCollectionViewViewModel <NSFBaseViewModel, NSFAllOptionalCollectionViewDataSource, UICollectionViewDelegate>
@optional

/**
 *  refresh 列表的 signal，标准的返回内容是一个 NSNumber，表征该列表数据是否为空
 */
@property (readonly) RACSignal *cv_refreshSignal;
@property (nullable, readonly) RACSignal *cv_moreSignal;

/**
 不通过网络请求触发的刷新列表需求通过这个 signal 来发出
 */
@property (nullable, readonly) RACSubject *cv_manuallyReloadDataSignal;

#pragma mark - 数据变化
/**
 sendNext 传出 VM 刚刚插入的行，VC 可以订阅它来执行动画
 */
@property (nullable, readonly) RACSubject *cv_justInsertedIndexPaths;

/**
 sendNext 传出 VM 刚刚删除的行，VC 可以订阅它来执行动画
 */
@property (nullable, readonly) RACSubject *cv_justDeletedIndexPaths;

#pragma mark - Model、ViewModel
- (nullable id)cv_model4RowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  供 cell 使用的数据，可以是 model 或者 viewModel
 */
- (nullable id)cv_cellViewModel4RowAtIndexPath:(NSIndexPath *)indexPath;

/**
 model 嵌套的话，也可能有 section 级的 model
 */
- (nullable id)cv_model4Section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
