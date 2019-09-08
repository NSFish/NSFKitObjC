//
//  YFYTableViewViewModelProtocol.h
//  CoolOffice
//
//  Created by le xingyu on 15/11/17.
//  Copyright © 2015年 lxzhh. All rights reserved.
//

#import "NSFBaseViewModelProtocol.h"
#import <ReactiveObjC/RACSignal.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NSFAllOptionalTableViewDataSource <NSObject>
@optional

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end


/**
 *  TableView 对应的 ViewModel 的基本 Protocol
 */
@protocol NSFTableViewViewModel<NSFBaseViewModel, NSFAllOptionalTableViewDataSource, UITableViewDelegate>
@optional

/**
 *  refresh 列表的 signal，标准的返回内容是一个 NSNumber，表征该列表数据是否为空
 */
@property (readonly) RACSignal<NSNumber *> *tv_refreshSignal;
@property (nullable, readonly) RACSignal<NSNumber *> *tv_moreSignal;

/**
 表征分页列表是否还有未加载数据
 */
@property (nonatomic, assign, readonly) BOOL hasMoreData;

/**
 不通过网络请求触发的刷新列表需求通过这个 signal 来发出
 */
@property (nullable, readonly) RACSubject *tv_manuallyReloadDataSignal;

#pragma mark - 数据变化
/**
 sendNext 传出 VM 刚刚插入的行，VC 可以订阅它来执行动画
 */
@property (nullable, readonly) RACSubject *tv_justInsertedIndexPaths;

/**
 sendNext 传出 VM 刚刚删除的行，VC 可以订阅它来执行动画
 */
@property (nullable, readonly) RACSubject *tv_justDeletedIndexPaths;

#pragma mark - Model、ViewModel
- (nullable id)tv_model4RowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  供 cell 使用的数据，可以是 model 或者 viewModel
 */
- (nullable id)tv_cellViewModel4RowAtIndexPath:(NSIndexPath *)indexPath;

/**
 model 嵌套的话，也可能有 section 级的 model
 */
- (nullable id)tv_model4Section:(NSInteger)section;

/**
 *  供 sectionHeader 使用的数据，可以是 model 或者 viewModel
 */
- (nullable id)tv_sectionHeaderViewModel4Section:(NSInteger)section;

/**
 *  供 sectionFooter 使用的数据，可以是 model 或者 viewModel
 */
- (nullable id)tv_sectionFooterViewModel4Section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

