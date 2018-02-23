//
//  GestureView.m
//  quartz 2d的练习
//
//  Created by apple on 2018/2/23.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "GestureView.h"
#define ButtonW 70
#define ButtonLeftMargen 30
#define ButtonTopMargen 30
#define ButtonCommonMargen 10

@interface GestureView ()

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (assign, nonatomic) CGPoint currentP;

@end
@implementation GestureView

-(NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // 创建button
    for (NSInteger index = 0; index < 9; index ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"gesture_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_selected"] forState:UIControlStateSelected];
        button.tag = index;
        button.userInteractionEnabled = NO;
        [self addSubview:button];
    }
}
/**
 改变一些frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 在这里正式的设置button
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        UIButton *button = (UIButton *)self.subviews[index];
        CGFloat buttonL = (index % 3)*(ButtonW + ButtonCommonMargen);
        CGFloat buttonT = (index / 3)*(ButtonW + ButtonCommonMargen);
        button.frame = CGRectMake(ButtonLeftMargen + buttonL, ButtonTopMargen + buttonT, ButtonW, ButtonW);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentP = [self getPointWithTouchs:touches];
    UIButton *button = [self getButtonThroughPoint:currentP];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.buttonArray addObject:button];
        [self setNeedsDisplay];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentP = [self getPointWithTouchs:touches];
    UIButton *button = [self getButtonThroughPoint:currentP];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.buttonArray addObject:button];
        
    }
    self.currentP = currentP;
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *str = [[NSString alloc] init];
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%zd",button.tag]];
    }
    NSLog(@"你想要的结果是 ： %@",str);
    [self.buttonArray removeAllObjects];
    [self setNeedsDisplay];
    
    
    
}

/**
 通过一个点来获取button

 @param point 点
 @return 按钮
 */
- (UIButton *)getButtonThroughPoint:(CGPoint)point {
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}
/**
 通过touches来获得当前的点

 @param touches touches
 @return 获取的点
 */
- (CGPoint )getPointWithTouchs:(NSSet <UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

/**
 开始绘制

 @param rect 矩形
 */
- (void)drawRect:(CGRect)rect {
    
    if (self.buttonArray.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger index = 0; index < self.buttonArray.count; index ++) {
        UIButton *button = (UIButton *)self.buttonArray[index];
        if (index == 0) {
            [path moveToPoint:button.center];
        }else {
            [path addLineToPoint:button.center];
        }
    }
    if (self.currentP.x > 0) {
       [path addLineToPoint:self.currentP];
    }
    [[UIColor greenColor] set];
    path.lineWidth = 5;
    [path setLineJoinStyle:kCGLineJoinRound];
    [path stroke];
    
}

@end
