//
//  NSFTableViewDelegateProxy.h
//
//  Created by 乐星宇 on 16/9/8.
//  Copyright © 2016年 lxzhh. All rights reserved.
//

#import "NSFPrioritizedDelegateContainer.h"
#import "NSFTableViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NSFTableViewViewModel;

/**
 将 UITableView.dataSource/delegate 的方法调用转发给传入的 viewModel 或 VC
 */
@interface NSFTableViewDelegateProxy : NSFPrioritizedDelegateContainer<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithViewController:(UIViewController<NSFAllOptionalTableViewDataSource, UITableViewDelegate> *)viewController
                             viewModel:(id<NSFAllOptionalTableViewDataSource, UITableViewDelegate>)viewModel NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDelegates:(NSArray<id<NSObject>> *)delegates
                          weakRef:(BOOL)weakRef NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
