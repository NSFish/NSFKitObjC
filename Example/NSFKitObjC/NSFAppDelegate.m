//
//  NSFAppDelegate.m
//  NSFKitObjC
//
//  Created by NSFish on 11/01/2018.
//  Copyright (c) 2018 NSFish. All rights reserved.
//

#import "NSFAppDelegate.h"
#import "NSFViewController.h"

@implementation NSFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSFViewController *vc = [[NSFViewController alloc] initWithStyle:UITableViewStylePlain];
    self.window.rootViewController = [UINavigationController embed:vc];
    
    return YES;
}

@end
