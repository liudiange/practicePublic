//
//  ViewController.m
//  类似于网易的新闻的框架
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LDGTitleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *titleArray = @[@"好日子",@"天下",@"地",@"大草原美",@"阿时间大家圣诞节啊睡觉的"];
    
    UIViewController *viewVc1 = [[UIViewController alloc] init];
    viewVc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *viewVc2 = [[UIViewController alloc] init];
    viewVc2.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *viewVc3 = [[UIViewController alloc] init];
    viewVc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *viewVc4 = [[UIViewController alloc] init];
    viewVc4.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *viewVc5 = [[UIViewController alloc] init];
    viewVc5.view.backgroundColor = [UIColor grayColor];
    NSArray *viewVcArray = @[viewVc1,viewVc2,viewVc3,viewVc4,viewVc5];
    
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.titleViewY = 64;
    
    LDGTitleView *titleView = [[LDGTitleView alloc] initWithTitleViewFrame:self.view.bounds titleHeight:35 titles:titleArray bottomControllers:viewVcArray currentController:self commonModel:commonModel];
    [self.view addSubview:titleView];
    
}


@end
