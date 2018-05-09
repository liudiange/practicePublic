//
//  LDGNavigationController.m
//  ZhiBo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGNavigationController.h"

@interface LDGNavigationController ()

@end

@implementation LDGNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[self imageWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 64) color:[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.6]] forBarMetrics:UIBarMetricsDefault];
    
}

/**
 拦截系统的push方法

 @param viewController 要推送的控制器
 @param animated 动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"CXCo_ic_return"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"CXCo_ic_return"] forState:UIControlStateSelected];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
/**
 根据颜色来生成图片

 @param frame 尺寸
 @param color 颜色
 @return 返回值
 */
- (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color {
    
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIColor *redColor = color;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [redColor CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 返回的事件
 */
- (void)backAction{
    [self popViewControllerAnimated:YES];
}
/**
改变状态栏的状态

 @return 要返回的状态
 */
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
