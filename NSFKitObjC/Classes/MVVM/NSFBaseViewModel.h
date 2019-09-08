//
//  NSFBaseViewModel.h
//  NSFKitObjC
//
//  Created by shlexingyu on 2018/11/12.
//

#import <Foundation/Foundation.h>
#import "NSFBaseViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFBaseViewModel : NSObject<NSFBaseViewModel>

@property (nonatomic, copy, nullable) NSString *title;

@end

NS_ASSUME_NONNULL_END
