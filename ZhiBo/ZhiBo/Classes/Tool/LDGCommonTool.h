//
//  LDGCommonTool.h
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LDGCommonTool : NSObject
/**
 开始例子动画的效果
 
 @param point 显示的位置
 @param controller 传递过来的控制器
 */
+ (void)startEmitterAnimation:(CGPoint )point withController:(UIViewController *)controller;
/**
 结束动画

 @param controller 传进来的控制器
 */
+ (void)stopEmitterAnimationWithController:(UIViewController *)controller;

@end
