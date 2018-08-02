//
//  AppDelegate.h
//  iOS横屏竖屏问题
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 是否强制横屏
 */
@property (assign, nonatomic) BOOL isForcePortrait;

@end

