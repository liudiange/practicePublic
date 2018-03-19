//
//  DrewView.m
//  基本动画的练习
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DrewView.h"

@interface DrewView ()

@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) CALayer *myLayer;
@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;


@end

@implementation DrewView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    // 创建一个path
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
    // 创建手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGes];
    
    // 创建一个layer
    CALayer *myLayer = [[CALayer alloc] init];
    myLayer.frame = CGRectMake(-10, 0, 10, 10);
    myLayer.cornerRadius = 5;
    myLayer.backgroundColor = [UIColor redColor].CGColor;
    self.myLayer = myLayer;
    // 创建复制层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceDelay = 0.25;
    [replicatorLayer addSublayer:self.myLayer];
    [self.layer addSublayer:replicatorLayer];
    self.replicatorLayer = replicatorLayer;
    
}

/**
 拖拽的手势

 @param panGes 手势
 */
- (void)panAction:(UIPanGestureRecognizer *)panGes{
    
    CGPoint currentPoint = [panGes locationInView:self];
    if (panGes.state == UIGestureRecognizerStateBegan) {
      [self.path moveToPoint:currentPoint];
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }else if (panGes.state == UIGestureRecognizerStateEnded){
        [self setNeedsDisplay];
    }
}
/**
 开始绘制

 @param rect rect
 */
-(void)drawRect:(CGRect)rect {
    [self.path stroke];
    
}
/**
 开始的事件
 */
- (void)startAction{
    // 创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.path.CGPath;
    animation.duration = 1.0;
    animation.repeatCount = NSIntegerMax;
    // 自动复位
    animation.autoreverses = YES;
    // 消除停在最后的位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 动画匀速
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.myLayer addAnimation:animation forKey:nil];
    // 复制层
    self.replicatorLayer.instanceCount = 30;
//    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(0, 2, 0);
    
}
/**
 重绘的方法
 */
- (void)redrewAction{
    [self.path removeAllPoints];
    [self.myLayer removeAllAnimations];
    [self setNeedsDisplay];
}


@end
