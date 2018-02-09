//
//  RedView.m
//  quartz 2d的练习
//
//  Created by 刘殿阁 on 2018/2/4.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "RedView.h"
#define kBorderWith 20

@implementation RedView

- (void)drawRect:(CGRect)rect {
    
   
}
/**
 缩放
 */
- (void)contextScale {
    // 创建上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 创建一个实心圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 100, 50)];
    // 设置颜色
    [[UIColor greenColor] setFill];
    // 缩放
    CGContextScaleCTM(ctx, 2.0, 2.0);
    // 开始绘制
    [path fill];
    
}
/**
 上下文的状态栈
 */
- (void)stateCgcontextRef {
    //  创建上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //  创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //  创建一条直线
    [path moveToPoint:CGPointMake(10, 100)];
    [path addLineToPoint:CGPointMake(190, 100)];
    //  将当前的上下文添加到上下文的栈里
    CGContextSaveGState(ctx);
    //  设置颜色和宽度
    [[UIColor greenColor] setStroke];
    CGContextSetLineWidth(ctx, 10);
    //  将路径添加到上下文上
    CGContextAddPath(ctx, path.CGPath);
    //  开始绘制
    CGContextStrokePath(ctx);
    
    // 从新初始化路径
    path = [UIBezierPath bezierPath];
    // 恢复最开始的状态
    CGContextRestoreGState(ctx);
    // 绘制路径
    [path moveToPoint:CGPointMake(100, 10)];
    [path addLineToPoint:CGPointMake(100, 190)];
    //  设置颜色和宽度
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(ctx, 5);
    // 将路径添加到上下文上
    CGContextAddPath(ctx, path.CGPath);
    // 开始绘制
    CGContextStrokePath(ctx);
}
/**
 画image
 */
- (void)drawImage {
    UIImage *image = [UIImage imageNamed:@"美眉"];
    // 显示不完全 按照实际的比例进行显示
    [image drawAsPatternInRect:self.bounds];
}
- (void)drawTextInRect {
    NSString *str = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    NSShadow *shadow = [[NSShadow alloc] init];
    // 宽高的偏移
    shadow.shadowOffset = CGSizeMake(10, 10);
    // 暗影颜色
    shadow.shadowColor = [UIColor greenColor];
    // 模糊
    shadow.shadowBlurRadius = 5;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:30],
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSShadowAttributeName : shadow
                          };
    [str drawInRect:self.bounds withAttributes:dic];
}
/**
 画文字
 */
- (void)drawText {
    NSString *str = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    NSShadow *shadow = [[NSShadow alloc] init];
    // 宽高的偏移
    shadow.shadowOffset = CGSizeMake(10, 10);
    // 暗影颜色
    shadow.shadowColor = [UIColor greenColor];
    // 模糊
    shadow.shadowBlurRadius = 5;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:30],
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSShadowAttributeName : shadow
                          };
    [str drawAtPoint:CGPointZero withAttributes:dic];
}
/**
 画一个空心的圆弧
 */
-(void)drawArc {
    // 开始的角度
    CGFloat startA = -M_PI_2;
    // 结束的角度
    CGFloat endA = M_PI_2;
    // 开始创建路径（clockwise ： yes  是顺时针 no：逆时针）
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:80 startAngle:startA endAngle:endA clockwise:YES];
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 宽度
    path.lineWidth = 10;
    // 开始绘制
    [path stroke];
}
/**
 画一个实心的圆弧
 */
- (void)drawRealArc {
    // 开始的角度
    CGFloat startA = -M_PI_2;
    // 结束的角度
    CGFloat endA = M_PI_2;
    // 开始创建路径（clockwise ： yes  是顺时针 no：逆时针）
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:80 startAngle:startA endAngle:endA clockwise:YES];
    // 设置颜色
    [[UIColor greenColor] setFill];
    // 开始绘制
    [path fill];
}
/**
 画一个实心的椭圆
 */
- (void)drawRealOval {
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 180, 100)];
    // 设置颜色
    [[UIColor greenColor] setFill];
    // 开始绘制
    [path fill];
}
/**
 画一个空心的椭圆
 */
-(void)drawOval {
    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 180, 100)];
    // 设置宽度
    path.lineWidth = 10;
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 开始绘制
    [path stroke];
}
/**
 画一个实心圆
 */
- (void)drawRealRound {
    // 创建上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // frame
    CGRect frame = CGRectMake(10, 10, 100, 100);
    // 设置颜色
    [[UIColor greenColor] set];
    // 画一个圆形的区域
    CGContextAddEllipseInRect(ctx, frame);
    // 开始绘制
    CGContextFillPath(ctx);
}
/**
 画圆（空心圆）
 */
- (void)drawRound {
    // 用这个方法创建的时候已经默认创建了上下文
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:50];
    // 设置四个角的样式
    path.lineJoinStyle = kCGLineJoinRound;
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 设置边角宽度
    path.lineWidth = 10.0;
    // 开始绘制
    [path stroke];
}
/**
 画一个矩形
 */
- (void)drawRect{
    // 用这个方法创建的时候已经默认创建了上下文
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 100)];
    // 设置四个角的样式
    path.lineJoinStyle = kCGLineJoinRound;
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 设置边角宽度
    path.lineWidth = 10.0;
    // 开始绘制
    [path stroke];
}
/**
 画曲线
 */
- (void)addQuadCurve {
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 创建路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //创建起始点
    [path moveToPoint:CGPointMake(10, 100)];
    // 画曲线
    [path addQuadCurveToPoint:CGPointMake(180, 100) controlPoint:CGPointMake(100, 0)];
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 设置线宽
    CGContextSetLineWidth(ctx, 10);
    // 设置两条线的尾部的圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 将路径添加到上下文上
    CGContextAddPath(ctx, path.CGPath);
    // 进行绘制
    CGContextStrokePath(ctx);
    
}
/**
 画直线
 */
-(void)drawLine {
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 创建路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    // 创建起点
    [path moveToPoint:CGPointMake(10, 100)];
    // 创建终点
    [path addLineToPoint:CGPointMake(100, 10)];
    // 在加上一个终点
    [path addLineToPoint:CGPointMake(180, 100)];
    // 设置线宽
    CGContextSetLineWidth(ctx, 10);
    // 设置颜色
    [[UIColor greenColor] setStroke];
    // 添加圆角（在两条线连接的地方）
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    // 设置两条线的尾部的圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 将路径添加到上下文上
    CGContextAddPath(ctx, path.CGPath);
    // 进行绘制
    CGContextStrokePath(ctx);

}

@end
