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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 进行绘制
    [self.view.layer renderInContext:ctx];
    // 获取图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 保持原比例
    NSData *data = UIImageJPEGRepresentation(getImage, 1.0);
    [data writeToFile:@"/Users/apple/Desktop/l.jpg" atomically:YES];
}
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
