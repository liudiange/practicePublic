//
//  ViewController.m
//  quartz 2d的练习
//
//  Created by 刘殿阁 on 2018/2/4.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import "LDGImageView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
