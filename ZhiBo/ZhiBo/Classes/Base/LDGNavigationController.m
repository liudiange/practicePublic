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
改变状态栏的状态

 @return 要返回的状态
 */
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
