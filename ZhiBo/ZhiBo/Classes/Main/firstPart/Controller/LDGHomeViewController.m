//
//  LDGHomeViewController.m
//  ZhiBo
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeViewController.h"
#import <MJExtension/MJExtension.h>
#import "LDGHomeModel.h"
#import "LDGHomeBaseController.h"
#import "LDGTitleView.h"

@interface LDGHomeViewController ()<UITextFieldDelegate>


@end

@implementation LDGHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    [self getNetWorkData];
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
/**
 获取数据 封装网络
 */
- (void)getNetWorkData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"types.plist" ofType:nil];
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *controllerArray = [NSMutableArray array];
    NSMutableArray *typeArray = [LDGHomeModel mj_objectArrayWithFile:path];
    for (LDGHomeModel *model in typeArray) {
        LDGHomeBaseController *baseController = [[LDGHomeBaseController alloc] init];
        baseController.model = model;
        [titleArray addObject:model.title];
        [controllerArray addObject:baseController];
    }
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.titleViewY = 64;
    LDGTitleView *titleView = [[LDGTitleView alloc] initWithTitleViewFrame:self.view.bounds titleHeight:35 titles:titleArray bottomControllers:controllerArray currentController:self commonModel:commonModel];
    [self.view addSubview:titleView];
    
}
@end
