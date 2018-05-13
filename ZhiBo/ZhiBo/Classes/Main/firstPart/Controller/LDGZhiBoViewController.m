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


#define MESSAGEBAR 50
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
    [self addNotification];
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
    // 添加message的在底部键盘
    LDGMessageView *messageView = [LDGMessageView loadViewXib];
    messageView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, MESSAGEBAR);
    [self.view addSubview:messageView];
    self.messageView = messageView;
    
}
/**
 监听键盘的点击
 */
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - 其他事件的处理
/**
 键盘的事件的处理

 @param info 通知信息
 */
- (void)keyBoardChangeAction:(NSNotification *)info{

    CGRect keyboardRect = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = ScreenHeight - keyboardRect.origin.y;
    if (keyboardH > 0) { // 键盘谈起来
        self.messageView.xmg_top = keyboardRect.origin.y - MESSAGEBAR;
    }else { // 键盘落下去
        self.messageView.xmg_top = ScreenHeight;
    }
    [UIView animateWithDuration:0.25 animations:^{
        // 防止在后面来回跳动
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.view layoutIfNeeded];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
