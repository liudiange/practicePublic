//
//  AppDelegate.m
//  MVVM优化
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "DGHomeViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    DGHomeViewController *homeVc = [[DGHomeViewController alloc] init];
    self.window.rootViewController = homeVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
