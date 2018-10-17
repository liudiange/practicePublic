//
//  DGNavigationController.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGNavigationController.h"

@interface DGNavigationController ()

@end

@implementation DGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景
    self.navigationBar.barTintColor = [UIColor redColor];
    
}

/**
 拦截系统的push方法

 @param viewController 压栈的控制器
 @param animated 动画效果
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        // 创建返回的按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    [super pushViewController:viewController animated:YES];
}
#pragma mark - 其他事件的响应
/**
 返回的事件
 */
- (void)backAction{
    [self popViewControllerAnimated:YES];
}
/**
 设置状态栏的颜色

 @return 状态栏的类型
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
