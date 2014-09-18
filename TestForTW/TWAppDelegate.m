//
//  TWAppDelegate.m
//  TestForTW
//
//  Created by TWc on 14-9-17.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWAppDelegate.h"
#import "TWFirstTableViewController.h"

@implementation TWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    TWFirstTableViewController *firViewController = [[TWFirstTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:firViewController];
    self.window.rootViewController = navigation;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
