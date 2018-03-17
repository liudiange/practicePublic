//
//  MGSCXPlayAnimationView.m
//  MiguSoundCXCo
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 cmcc. All rights reserved.
//

#import "MGSCXPlayAnimationView.h"

@interface MGSCXPlayAnimationView ()
/**
 每一个条之间的距离
 */
@property (assign, nonatomic) CGFloat perConstaton;

@end

@implementation MGSCXPlayAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 配置默认的数据
        [self configDefaultData];
    }
    return self;
}
-(void)awakeFromNib {
    [super awakeFromNib];
    // 配置默认的数据
    [self configDefaultData];
}
#pragma mark - 一些方法的调用
/**
 配置默认的数据
 */
- (void)configDefaultData{
    // 颜色
    if (!self.animation_Color) {
        self.animation_Color = [UIColor redColor];
    }
    // 宽度 条数
    if (self.animation_PerWith == 0) {
        if (self.bounds.size.width >= 20) {
            self.animation_PerWith = 4;
            self.animation_count = 5;
        }else if (self.bounds.size.width > 10){
            self.animation_PerWith = 3;
            self.animation_count = 3;
        }else{
            self.animation_count = 3;
            self.animation_PerWith = 1.0 * self.bounds.size.width/self.animation_count - 0.5;
        }
    }
    // 速度
    if (self.animation_Speed == 0) {
        self.animation_Speed = 0.75;
    }
}
/**
 创建layer
 */
- (void)creatLayer{
    
    self.perConstaton = 1.0*(self.bounds.size.width - (self.animation_PerWith*self.animation_count))/self.animation_count;
    if (self.perConstaton < 0) {
       self.perConstaton = [self calculatorConstaton];
    }
    // 程序走到这是 一切值应该都是对的
    // 创建layer
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.animation_PerWith, self.bounds.size.height);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.backgroundColor = self.animation_Color.CGColor;
    layer.position = CGPointMake(0, self.bounds.size.height);
    // 添加一个动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    if (self.animation_Speed >= 1) {
        self.animation_Speed = 0.95;
    }else if (self.animation_Speed <= 0){
        self.animation_Speed = 0.05;
    }
    animation.duration = 1- self.animation_Speed;
    animation.fromValue = @(0.3);
    animation.toValue = @(1);
    animation.repeatCount = NSIntegerMax;
    // 自动反弹
    animation.autoreverses = YES;
    // 动画结束后停在最后位置的解决办法
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:nil];
    // 创建复制层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = self.animation_count;
    replicatorLayer.instanceDelay = 1 - self.animation_Speed;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation((self.animation_PerWith +self.perConstaton), 0, 0);
    [replicatorLayer addSublayer:layer];
    [self.layer addSublayer:replicatorLayer];
}
/**
 计算每一个条之间的间距
 */
- (CGFloat)calculatorConstaton{
    CGFloat constation = 0.0;
    self.animation_count -= 1;
     constation = 1.0*(self.bounds.size.width - (self.animation_PerWith*self.animation_count))/self.animation_count;
    if (constation < 0) {
       constation = [self calculatorConstaton];
    }
    return constation;
}

/**
 当大于最大宽度的时候 做限制

 @param animation_PerWith 宽度
 */
-(void)setAnimation_PerWith:(CGFloat)animation_PerWith {
    if (animation_PerWith >= self.bounds.size.width) {
        animation_PerWith = self.bounds.size.width;
    }
    _animation_PerWith = animation_PerWith;
}
#pragma mark - 动画的基本的
/**
 开始动画
 */
- (void)startAnimation{
    if (self.layer.sublayers.count) {
        for (CALayer *layer in self.layer.sublayers) {
            [self resumeAnimateWithLayer:layer];
        }
    }else{
        // 创建layer
        [self creatLayer];
    }
}
/**
 结束动画
 */
- (void)stopAnimation{
    for (CALayer *layer in self.layer.sublayers) {
        [self pauseAnimateWithLyer:layer];
    }
}
/**
 暂停layer

 @param layer layer
 */
- (void)pauseAnimateWithLyer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

/**
 恢复动画layer

 @param layer layer
 */
- (void)resumeAnimateWithLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
