//
//  DrawView.m
//  quartz 2d的练习
//
//  Created by apple on 2018/2/26.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "DrawView.h"
#import "DrawBezierPath.h"

@interface DrawView ()

@property (strong, nonatomic) DrawBezierPath *drawPath;
@property (strong, nonatomic) NSMutableArray *pathArray;



@end
@implementation DrawView
-(NSMutableArray *)pathArray {
    if (!_pathArray) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // 添加拖拽的事件
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGes];
}

/**
 手势拖拽的响应

 @param panGesture 拖拽手势
 */
- (void)panAction:(UIPanGestureRecognizer *)panGesture{
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        self.drawPath = [DrawBezierPath bezierPath];
        CGPoint currentPoint = [panGesture locationInView:self];
        [self.drawPath moveToPoint:currentPoint];
        _width > 0 ? (self.drawPath.lineWidth = _width):(self.drawPath.lineWidth = 1);
        _color != nil ? (self.drawPath.pathColor = _color) : (self.drawPath.pathColor = [UIColor blackColor]);
        [self.pathArray addObject:self.drawPath];
    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        CGPoint currentPoint = [panGesture locationInView:self];
        [self.drawPath addLineToPoint:currentPoint];
    }
    [self setNeedsDisplay];
}

#pragma mark - 外部事件的响应
/**
 清除的操作
 */
- (void)clearAction{
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}
/**
 撤销的操作
 */
- (void)undoAction {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}
/**
 橡皮擦的事件
 */
- (void)eraserAction{
    self.color = self.backgroundColor;
    [self setNeedsDisplay];
}

/**
 设置颜色
 
 @param color 颜色
 */
- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}
/**
 设置宽度
 
 @param width 宽度
 */
- (void)setWidth:(CGFloat)width{
    _width = width;
    [self setNeedsDisplay];
}

/**
 绘制上下文的部分

 @param rect 当前的上下文的区域
 */
- (void)drawRect:(CGRect)rect {
    
    for (DrawBezierPath *path in self.pathArray) {
        [path.pathColor set];
        [path stroke];
    }
}

@end
