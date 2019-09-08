//
//  UICollectionView+NSFExt.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (NSFExt)

@property (nonatomic, copy, nullable, setter=nsf_setNestedIndexPath:) NSIndexPath *nsf_nestedIndexPath;

/**
 注册 cell，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerCell:(Class)cellClass;

/**
 注册 SupplementaryView，自动区分 cell 是否有对应的 nib，自动分配 reuseID
 */
- (void)nsf_registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind;

@end

NS_ASSUME_NONNULL_END
