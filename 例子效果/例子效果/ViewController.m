//
//  ViewController.m
//  例子效果
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建粒子效果的layer
    CAEmitterLayer *emiterLayer = [[CAEmitterLayer alloc] init];
    // 创建发射器的位置
    emiterLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, 100);
    // 开启三维的效果
    emiterLayer.preservesDepth = YES;
    // 创建每一个cell 并且给每一个cell添加属性
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    // 设置粒子的速度
    cell.velocity = 100;
    cell.velocityRange = 50;
    // 例子的大小 scaleRange:(相当于scale 是 1.2 - 0.2)
    cell.scale = 0.7;
    cell.scaleRange = 0.5;
    // 粒子的方向
    cell.emissionLongitude = M_PI_2;
    cell.emissionRange = 0.5 * M_PI_2;
    // 设置每一秒弹出多少个
    cell.birthRate = 10;
    // 设置例子的旋转
    cell.spin = M_PI_2;
    cell.spinRange = M_PI_2;
    // 例子的存活时间
    cell.lifetime = 5;
    cell.lifetimeRange = 3;
    // 设置粒子的图片
    cell.contents = (id)[UIImage imageNamed:@"good6_30x30_"].CGImage;
    emiterLayer.emitterCells = @[cell];
    [self.view.layer addSublayer:emiterLayer];
    
}


@end
