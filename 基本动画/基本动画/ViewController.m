//
//  ViewController.m
//  基本动画
//
//  Created by 刘殿阁 on 2018/3/11.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@property(weak, nonatomic)CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(30,50);
    self.layer = layer;
    [self.view.layer addSublayer:layer];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [CATransaction begin];
    // 取消动画
    [CATransaction setDisableActions:YES];
    // 设置动画的时常
    [CATransaction setAnimationDuration:5.0];
    self.layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer.position = CGPointMake(100, 200);
    [CATransaction commit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
