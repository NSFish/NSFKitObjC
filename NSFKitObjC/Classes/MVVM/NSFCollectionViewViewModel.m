//
//  NSFCollectionViewViewModel.m
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFCollectionViewViewModel.h"

@implementation NSFCollectionViewViewModel

#pragma mark - NSFCollectionViewViewModel
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (id)cv_cellViewModel4RowAtIndexPath:(NSIndexPath *)indexPath
{
    // 默认情况下 cell 就直接使用 model 了
    return [self cv_model4RowAtIndexPath:indexPath];
}

@end
