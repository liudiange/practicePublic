//
//  AppDelegate.m
//  iOS横屏竖屏问题
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIApplicationDelegate>

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.isForcePortrait = YES;
    
    return YES;
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    
//    return UIInterfaceOrientationMaskAll;
    
    if (self.isForcePortrait) {
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return UIInterfaceOrientationMaskLandscapeLeft;
    }
}

@end
