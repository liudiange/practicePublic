//
//  LDGCommonTool.m
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGCommonTool.h"

@implementation LDGCommonTool
/**
 开始例子动画的效果
 
 @param point 显示的位置
 @param controller 传递过来的控制器
 */
+ (void)startEmitterAnimation:(CGPoint )point withController:(UIViewController *)controller{
    
    // 创建粒子效果的layer
    CAEmitterLayer *emiterLayer = [[CAEmitterLayer alloc] init];
    // 创建发射器的位置
    emiterLayer.position = point;
    // 开启三维的效果
    emiterLayer.preservesDepth = YES;
    NSMutableArray *temCellArray = [NSMutableArray array];
    for (NSInteger index = 0; index < 6; index ++) {
        // 创建每一个cell 并且给每一个cell添加属性
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        // 设置粒子的速度
        cell.velocity = 100;
        cell.velocityRange = 50;
        // 例子的大小 scaleRange:(相当于scale 是 1.2 - 0.2)
        cell.scale = 0.7;
        cell.scaleRange = 0.5;
        // 粒子的方向
        cell.emissionLongitude = -M_PI_2;
        cell.emissionRange = 0.25 * M_PI_2;
        // 设置每一秒弹出多少个
        cell.birthRate = 6;
        // 设置例子的旋转
        cell.spin = M_PI_2;
        cell.spinRange = M_PI_2;	
        // 例子的存活时间
        cell.lifetime = 3;
        cell.lifetimeRange = 3;
        // 设置粒子的图片
        NSString *nameStr = [NSString stringWithFormat:@"good%zd_30x30",index];
        cell.contents = (id)[UIImage imageNamed:nameStr].CGImage;
        [temCellArray addObject:cell];
    }
    emiterLayer.emitterCells = temCellArray;
    emiterLayer.name = @"emiterLayer";
    [controller.view.layer addSublayer:emiterLayer];
}
/**
 结束动画
 
 @param controller 传进来的控制器
 */
+ (void)stopEmitterAnimationWithController:(UIViewController *)controller{
    
    CAEmitterLayer *emitterLayer;
    for (CALayer *layer in controller.view.layer.sublayers) {
        if ([layer isKindOfClass:[CAEmitterLayer class]]) {
            emitterLayer = (CAEmitterLayer *)layer;
            break;
        }
    }
    [emitterLayer removeFromSuperlayer];
}
@end
