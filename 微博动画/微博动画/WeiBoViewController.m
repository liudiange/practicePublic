//
//  WeiBoViewController.m
//  微博动画
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WeiBoViewController.h"

@interface WeiBoViewController ()

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int index;


@end
@implementation WeiBoViewController
-(NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self setUp];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
}

/**
 定时器改变的方法
 */
- (void)timerChange{
    if (self.index == self.buttonArray.count) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    UIButton *button = self.buttonArray[self.index];
    // 这个动画有弹性效果
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 恢复开始的样子
        button.transform = CGAffineTransformIdentity;
    } completion:nil];
    self.index ++;
}


/**
 初始化
 */
- (void)setUp{
    
    int row = 0;
    int column = 0;
    for (NSInteger index = 0; index < 6; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        row = (int)index/3;
        column = (int)index%3;
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(10 + column*(80 + 20), 467 + row*(80+20), 80, 80);
        [button setTitle:@"微博"forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonClickUpInside:) forControlEvents:UIControlEventTouchUpInside];
        // 移动到最底部
        button.transform = CGAffineTransformMakeTranslation(button.frame.origin.x, self.view.bounds.size.height);
        [self.buttonArray addObject:button];
        
    }
}

/**
 按钮按下事件

 @param button 按钮
 */
- (void)buttonClick:(UIButton *)button{
 
    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
}
/**
 按钮按下抬起

 @param button 按钮
 */
- (void)buttonClickUpInside:(UIButton *)button {
    
    [UIView animateWithDuration:1.0 animations:^{
        button.transform = CGAffineTransformMakeScale(2, 2);
    }completion:^(BOOL finished) {
        button.alpha = 0;
    }];
}
@end
