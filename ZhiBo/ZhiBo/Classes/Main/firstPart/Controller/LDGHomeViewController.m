//
//  LDGHomeViewController.m
//  ZhiBo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeViewController.h"

@interface LDGHomeViewController ()

@end

@implementation LDGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
}

/**
 导航栏初始化
 */
- (void)setNav{
    self.navigationItem.title = @"首页";

}

@end
