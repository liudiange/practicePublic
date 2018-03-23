//
//  LDGHomeViewController.m
//  ZhiBo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeViewController.h"

@interface LDGHomeViewController ()<UITextFieldDelegate>

@end

@implementation LDGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self setUp];
}
/**
 初始化
 */
- (void)setUp{
    
    // 创建一个搜索的框
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(0, 0, 300, 30);
    textField.borderStyle = UITextBorderStyleNone;
    textField.delegate = self;
    self.navigationItem.titleView = textField;
    textField.layer.cornerRadius = 15;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.tintColor = [UIColor greenColor];
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.frame = CGRectMake(0, 0, 22, 22);
    searchImageView.image = [UIImage imageNamed:@"CXCo_ic_search"];
    textField.leftView = searchImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;

}
@end
