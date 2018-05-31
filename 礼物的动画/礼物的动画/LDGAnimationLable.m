//
//  LDGAnimationLable.m
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGAnimationLable.h"

@implementation LDGAnimationLable

/**
 在这个方法中 给lable进行描边
 
 @param rect rect
 */
-(void)drawRect:(CGRect)rect{
    
    // 先画空心的lable
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ref, 5);
    CGContextSetLineJoin(ref, kCGLineJoinRound);
    CGContextSetTextDrawingMode(ref, kCGTextStroke);
    self.textColor = [UIColor orangeColor];
    [super drawRect:rect];
    // 画实心的lable
    self.textColor = [UIColor blackColor];
    CGContextSetTextDrawingMode(ref, kCGTextFill);
    [super drawRect:rect];
}

/**
 开始动画
 */
-(void)startAnimation:(void (^)(BOOL))complete{
    
    // 外面的这个动画是总的事件
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        
        // 这动画的事件是（0.5-0）*1.0
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(3.0, 3.0);
        }];
        // 这动画的事件是（1.0-0.5）*1.0
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:1.0 animations:^{
            self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        }];
    } completion:^(BOOL finished) {
        // 这个动画有弹簧属性
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            complete(YES);
        }];
    }];
}

@end
