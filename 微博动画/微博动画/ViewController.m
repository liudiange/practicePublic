//
//  ViewController.m
//  微博动画
//
//  Created by apple on 2018/3/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WeiBoViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 用CAShapeLayer 画一个圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 20;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 5.0;
    animation.repeatCount = NSIntegerMax;
    [shapeLayer addAnimation:animation forKey:nil];
    
    
    
    
}
- (IBAction)startAction {
    
    WeiBoViewController *weiboVc = [[WeiBoViewController alloc] init];
    [self presentViewController:weiboVc animated:YES completion:nil];
}


@end
