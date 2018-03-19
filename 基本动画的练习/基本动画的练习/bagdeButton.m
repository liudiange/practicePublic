//
//  bagdeButton.m
//  基本动画的练习
//
//  Created by apple on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "bagdeButton.h"


@interface bagdeButton ()

@property (strong, nonatomic) UIView *smallView;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;


@end
@implementation bagdeButton

-(CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
         // 创建根据路线显示涂层的层(形状图层)
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        [self.superview.layer insertSublayer:shapeLayer atIndex:0];
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}


-(void)awakeFromNib {
    [super awakeFromNib];
    // 初始化
    [self setUp];
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self setUp];
    }
    return self;
}
/**
 初始化
 */
- (void)setUp{
    
    // 本身的基本的设置
    self.layer.cornerRadius = self.bounds.size.width *0.5;
    self.layer.masksToBounds = YES;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor redColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12.0];
    // 添加拖拽的手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGes];
    // 添加小圆
    UIView *smallView = [[UIView alloc] initWithFrame:self.frame];
    smallView.backgroundColor = [UIColor redColor];
    smallView.layer.cornerRadius = self.bounds.size.width *0.5;
    self.smallView = smallView;
    [self.superview insertSubview:smallView belowSubview:self];
   
}
/**
 拖拽的手势

 @param panGes 手势
 */
- (void)panAction:(UIPanGestureRecognizer *)panGes {
    
    // 当前weiz的偏移量
    CGPoint panOff = [panGes locationInView:self.superview];
    CGRect frame = self.frame;
    frame.origin = panOff;
    self.frame = frame;
    
    
    // 计算两个圆直接的距离
    CGFloat dx1 = self.frame.origin.x - self.smallView.frame.origin.x;
    CGFloat dy1 = self.frame.origin.y - self.smallView.frame.origin.y;
    // 相当于求三角形的斜边
    CGFloat d = hypotf(dx1, dy1);
    // 改变小圆的frame
    CGRect smallRect = self.smallView.frame;
    CGFloat calculatorWidth = self.frame.size.width - self.frame.size.width *(1.0 * d/60);
    if (calculatorWidth <= 0) {
        calculatorWidth = 0;
    }
    smallRect.size.width = calculatorWidth;
    smallRect.size.height = calculatorWidth;
    self.smallView.frame = smallRect;
    self.smallView.layer.cornerRadius = calculatorWidth * 0.5;
    UIBezierPath *path = [self pathWithSmallView:self.smallView andBigView:self andRadius:d];
    self.shapeLayer.path = path.CGPath;
    
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (d < 60) {
            CGRect frame = self.frame;
            frame.origin = self.smallView.frame.origin;
            self.frame = frame;
            [self.shapeLayer removeFromSuperlayer];
            self.smallView.frame = self.frame;
            self.smallView.layer.cornerRadius = self.frame.size.width * 0.5;
            self.smallView.hidden = NO;
        }else {
            [self.shapeLayer removeFromSuperlayer];
            self.smallView.hidden = YES;
          
            // 创建一个imageview 来进行一个爆炸的效果
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100)];
            NSMutableArray *imagesArray = [NSMutableArray array];
            for (NSInteger index = 1; index < 4; index ++) {
                NSString *imageName = [NSString stringWithFormat:@"%zd",index];
                UIImage *image = [UIImage imageNamed:imageName];
                [imagesArray addObject:image];
            }
            imageView.animationImages = imagesArray;
            [imageView startAnimating];
            [self.superview addSubview:imageView];
            // 移动从父试图
            [self removeFromSuperview];
            
        }
        
    }
}
/**
 根据小圆和大圆返回路径
 
 @param smallView 小圆
 @param bigButton 大圆
 @param d 半径
 @return 路径
 */
- (UIBezierPath *)pathWithSmallView:(UIView *)smallView andBigView:(UIButton *)bigButton andRadius:(CGFloat )d{
    
    // 求各个点的值
    CGFloat x1 = smallView.center.x;
    CGFloat y1 = smallView.center.y;
    CGFloat x2 = bigButton.center.x;
    CGFloat y2 = bigButton.center.y;
    CGFloat r1 = smallView.frame.size.width * 0.5;
    CGFloat r2 = bigButton.frame.size.width * 0.5;
    
    CGFloat siny = (x2 - x1)/d;
    CGFloat cosy = (y1 - y2)/d;
    CGPoint A = CGPointMake(x1 - cosy*r1, y1 - siny*r1);
    CGPoint B = CGPointMake(x1 + cosy*r1, y1 + siny*r1);
    CGPoint C = CGPointMake(x2 - cosy*r2, y2 - siny*r2);
    CGPoint D = CGPointMake(x2 + cosy*r2, y2 + siny*r2);
    CGPoint P = CGPointMake(A.x + siny*d/2.0, A.y - cosy*d/2.0);
    CGPoint O = CGPointMake(B.x + siny*d/2.0, B.y - cosy*d/2.0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:A];
    // 曲线
    [path addQuadCurveToPoint:C controlPoint:P];
    [path addLineToPoint:D];
    // 曲线
    [path addQuadCurveToPoint:B controlPoint:O];
    [path addLineToPoint:A];
    return path;
}



















@end
