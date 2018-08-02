//
//  AppDelegate.m
//  应用内切换语言
//
//  Created by apple on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:AppKey]) {
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        
        if ([language hasPrefix:@"zh-Hans"]) {
            //开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppKey];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppKey];
        }
    }
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self launchMethod];
    [self.window makeKeyAndVisible];
    return YES;
    
}
- (void)launchMethod{
   
    //设置根控制器
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc]init];
    self.window.rootViewController = tabBarVc;
    
}
@end
