//
//  ViewController.m
//  iOS横屏竖屏问题
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()




@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
}

-(BOOL)shouldAutorotate{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isForcePortrait = YES;
    [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];

    // 强制屏幕旋转
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    // 进行刷新
    [UIViewController attemptRotationToDeviceOrientation];
    
    
}

@end
