//
//  AppDelegate.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "DGHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DGHomeViewController *homeViewVc = [[DGHomeViewController alloc] init];
    self.window.rootViewController = homeViewVc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
