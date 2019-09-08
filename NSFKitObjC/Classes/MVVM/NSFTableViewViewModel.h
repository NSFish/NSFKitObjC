//
//  NSFTableViewViewModel.h
//  AFNetworking
//
//  Created by shlexingyu on 2018/11/19.
//

#import "NSFBaseViewModel.h"
#import "NSFTableViewViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFTableViewViewModel : NSFBaseViewModel<NSFTableViewViewModel>
@property (nonatomic, assign) BOOL hasMoreData;

@end

NS_ASSUME_NONNULL_END
