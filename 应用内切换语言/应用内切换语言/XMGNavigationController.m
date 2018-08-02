//
//  XMGNavigationController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/8/9.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGNavigationController.h"

@interface XMGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
   
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        // 创建左边的返回键
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back {
    // 隐藏键盘
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}
#pragma mark - delegate 的方法
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

@end
