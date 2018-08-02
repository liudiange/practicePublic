//
//  DGTwoViewController.m
//  iOS横屏竖屏问题
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGTwoViewController.h"
#import "AppDelegate.h"

@interface DGTwoViewController ()

@end

@implementation DGTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isForcePortrait = NO;
    [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
    // 开始旋转
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
    // 刷新
    [UIViewController attemptRotationToDeviceOrientation];
    

}
/**
 支持自动旋转

 @return 是否支持旋转
 */
-(BOOL)shouldAutorotate{
    return YES;
}


@end
