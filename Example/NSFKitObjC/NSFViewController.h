//
//  NSFViewController.h
//  NSFKitObjC
//
//  Created by NSFish on 11/01/2018.
//  Copyright (c) 2018 NSFish. All rights reserved.
//

@import UIKit;
@import NSFKitObjC;

NS_ASSUME_NONNULL_BEGIN

@interface NSFViewController : NSFTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
                    viewModel:(id<NSFTableViewViewModel>)viewModel NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
