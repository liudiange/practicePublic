//
//  LDGZhiBoViewController.m
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGZhiBoViewController.h"
#import "LDGAuthorView.h"
#import "LDGZhiBoBottomView.h"

@interface LDGZhiBoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *followPeopleButton;
@property (weak, nonatomic) IBOutlet LDGAuthorView *authorView;
@property (weak, nonatomic) IBOutlet LDGZhiBoBottomView *bottomView;

@end

@implementation LDGZhiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化以及其他的相关的操作
    [self setUp];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
/**
 初始化的相关的操作
 */
- (void)setUp{
    
    self.navigationController.navigationBar.hidden = YES;
    self.authorView.authorModel = self.authorModel;
    self.bottomView.zhiboVc = self;
    
}
#pragma mark - 一些常规的按钮的点击事件
/**
 返回的点击事件

 @param sender 按钮
 */
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 关注的人的点击事件

 @param sender 按钮
 */
- (IBAction)followPeopleAction:(UIButton *)sender {
    
    LDGLog(@"点击了关注的人按钮");
}


@end
