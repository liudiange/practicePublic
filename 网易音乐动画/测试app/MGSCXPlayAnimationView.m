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
/**
 frame 改变的时候设置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
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
    if (self.animation_count == 0) {
        self.animation_count = 4;
    }
}
/**
 创建layer
 */
- (void)creatLayer{
    
    self.perConstaton = 1.0*(self.bounds.size.width - (self.animation_PerWith*self.animation_count))/self.animation_count;
    BOOL isConstatonSmall = [self setUpLayer];
    if (isConstatonSmall) {
        self.perConstaton = [self calculatorConstaton:self.animation_PerWith];
        [self setUpLayer];
    }
    // 便利layer进行动画开始
    for (CALayer *layer in self.layer.sublayers) {
        [self updateFrameLayer:layer];
    }
}

/**
 更改layer的frame

 @param layer layer
 */
- (void)updateFrameLayer:(CALayer *)layer{
    
    CGFloat updateY = 1.0 * arc4random_uniform(10)/10 *self.bounds.size.height;
    CGRect frame = layer.frame;
    frame.origin.y = updateY;
    frame.size.height = self.bounds.size.height - updateY;
    layer.frame = frame;
    if (self.animation_Speed >= 1) {
        self.animation_Speed = 0.05;
    }
    if (self.animation_Speed <= 0) {
        self.animation_Speed = 1;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1-self.animation_Speed) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateFrameLayer:layer];
    });
}
/**
 设置layer的frame的相关的问题

 @return layer
 */
- (BOOL)setUpLayer{
    BOOL isConstatonIsTooSamll = NO;
    for (NSInteger index = 0; index < self.animation_count; index ++) {
        CALayer *layer = [CALayer layer];
        if (self.perConstaton > 0) {
            layer.frame = CGRectMake(self.perConstaton + index*(self.animation_PerWith + self.perConstaton), 0, self.animation_PerWith, self.bounds.size.height);
            layer.backgroundColor = self.animation_Color.CGColor;
        }else{
            isConstatonIsTooSamll = YES;
            break;
        }
        [self.layer addSublayer:layer];
    }
    return isConstatonIsTooSamll;
}

/**
 计算每一个条之间的间距

 @param width 每一个条的宽度
 */
- (CGFloat)calculatorConstaton:(CGFloat)width{
    CGFloat constation = 0.0;
    self.animation_count -= 1;
     constation = 1.0*(self.bounds.size.width - (self.animation_PerWith*self.animation_count))/self.animation_count;
    if (constation <= 0) {
       constation = [self calculatorConstaton:self.animation_PerWith];
    }
    return constation;
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
