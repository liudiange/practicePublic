//
//  ViewController.m
//  quartz 2d的练习
//
//  Created by 刘殿阁 on 2018/2/4.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import "LDGImageView.h"
#import "UIImage+image.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (strong, nonatomic) UIView *corverView;
@property (assign, nonatomic) CGPoint startP;

@end

@implementation ViewController
-(UIView *)corverView {
    if (!_corverView) {
        _corverView = [[UIView alloc] init];
        _corverView.backgroundColor = [UIColor blackColor];
        _corverView.alpha = 0.7;
        [self.view addSubview:_corverView];
    }
    return _corverView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

/**
 拖拽事件

 @param sender 首饰
 */
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    
//--------------------------------------------------图片擦除-------------------------------------------------//
    // 擦除的宽度
    CGFloat width = 50;
    CGPoint currrentP = [sender locationInView:self.view];
    CGFloat pointX = currrentP.x - width *0.5;
    CGFloat pointY = currrentP.y - width *0.5;
    // 创建图片上下文
    UIGraphicsBeginImageContextWithOptions(self.displayImageView.bounds.size, NO, 0.0);
    // 获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 进行绘制
    [self.displayImageView.layer renderInContext:ctx];
    // 擦除区域
    CGRect clearRect = CGRectMake(pointX, pointY, width, width);
    // 进行擦除
    CGContextClearRect(ctx, clearRect);
    // 生成新的图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的上下文
    UIGraphicsEndImageContext();
    self.displayImageView.image = getImage;
    
//--------------------------------------------------图片裁剪-------------------------------------------------//
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        self.startP = [sender locationInView:self.view];
//
//    }else if (sender.state == UIGestureRecognizerStateChanged){
//        CGPoint currentP = [sender locationInView:self.view];
//        CGFloat width = currentP.x - self.startP.x;
//        CGFloat height = currentP.y - self.startP.y;
//        self.corverView.frame = CGRectMake(self.startP.x, self.startP.y, width, height);
//    }else if (sender.state == UIGestureRecognizerStateEnded){
//        // 开启图片的上下文
//        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
//        // 创建路径
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.corverView.frame];
//        // 超出部分进行裁剪
//        [path addClip];
//        // 拿到当前的上下文
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        // 开始绘制
//        [self.displayImageView.layer renderInContext:ctx];
//        // 获得图片
//        UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
//        // 关闭上下文
//        UIGraphicsEndImageContext();
//        self.displayImageView.image = getImage;
//        // 移除覆盖的view
//        [self.corverView removeFromSuperview];
//    }
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    // 开启图片上下文
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
//    // 获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 进行绘制
//    [self.view.layer renderInContext:ctx];
//    // 获取图片
//    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 关闭上下文
//    UIGraphicsEndImageContext();
//    // 保持原比例
//    NSData *data = UIImageJPEGRepresentation(getImage, 1.0);
//    [data writeToFile:@"/Users/apple/Desktop/l.jpg" atomically:YES];
//
//}
// 仿照系统生成imageView
-(void)test {
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0.0);
    // 创建image
    UIImage *image = [UIImage imageNamed:@"美眉"];
    [image drawInRect:CGRectMake(0, 0, 200, 200)];
    // 创建logo文字
    NSString *str = @"阿斯顿哈说的";
    [str drawAtPoint:CGPointMake(20, 20) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                                          NSForegroundColorAttributeName :[UIColor redColor]
                                                          }];
    
    // 获得上下文生成的图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束当前图片上下文
    UIGraphicsEndImageContext();
    
    self.displayImageView.image = getImage;
}

@end
