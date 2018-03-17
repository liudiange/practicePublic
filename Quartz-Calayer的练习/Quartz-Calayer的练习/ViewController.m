//
//  ViewController.m
//  Quartz-Calayer的练习
//
//  Created by apple on 2018/2/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView animateWithDuration:1.0 animations:^{
        
       
    }];
}
- (void)transform3D{
    [UIView animateWithDuration:1.0 animations:^{
        // 第一种方式
        
        //        // 3d的类型缩放
        //        self.displayImageView.layer.transform = CATransform3DMakeScale(1.5, 1.8, 3.0);
        //        // 3d类型旋转
        //        self.displayImageView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0, 1.0, 1.0);
        //        // 3d类型旋转
        //        self.displayImageView.layer.transform = CATransform3DMakeTranslation(100, 100, 100);
        //
        // 第二种方式
        [self.displayImageView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.8, 3.0)] forKeyPath:@"transform"];
        [self.displayImageView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1.0, 1.0, 1.0)] forKeyPath:@"transform"];
        [self.displayImageView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 100, 100)] forKeyPath:@"transform"];
        // 第三种方式 简单快速的实现 kvc 这种方式实现
        [self.displayImageView.layer setValue:@(1.5) forKeyPath:@"transform.scale"];
        [self.displayImageView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation"];
        [self.displayImageView.layer setValue:@(150) forKeyPath:@"transform.translation.x"];
        
    }];
}
/**
 两种方式比较
 */
-(void)compareBoth {
    // 第一种方式显示,可以裁剪
    self.redView.layer.cornerRadius = 50;
    // 第二种方式显示
    self.displayImageView.layer.cornerRadius = 50;
}
/**
 layer的简介
 */
- (void)testLayer{
    
    //  阴影的透明度，默认是完全透明的也就是0
    self.redView.layer.shadowOpacity = 1.0;
    //  设置阴影的颜色
    self.redView.layer.shadowColor = [UIColor greenColor].CGColor;
    //  设置阴影的偏移量
    self.redView.layer.shadowOffset = CGSizeMake(50, -50);
    //  设置阴影的模糊程度
    self.redView.layer.shadowRadius = 10;
}



@end
