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
#import "DrawView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (strong, nonatomic) UIView *corverView;
@property (assign, nonatomic) CGPoint startP;
@property (weak, nonatomic) IBOutlet DrawView *drawView;



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

#pragma mark - 涂层的相关的变化



#pragma mark - 涂鸦的相关的绘制
/**
 撤销的方法

 @param sender 对象本身
 */
- (IBAction)clearAction:(UIBarButtonItem *)sender {
    
    [self.drawView clearAction];
}

/**
 撤销的操作

 @param sender 对象本身
 */
- (IBAction)undoAction:(UIBarButtonItem *)sender {
    
    [self.drawView undoAction];
}

/**
 橡皮擦的功能

 @param sender 对象本身
 */
- (IBAction)eraserAction:(UIBarButtonItem *)sender {
    [self.drawView eraserAction];
}

/**
 照片的功能

 @param sender 对象本身
 */
- (IBAction)photoAction:(UIBarButtonItem *)sender {
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc] init];
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVc.delegate = self;
    [self presentViewController:pickerVc animated:YES completion:nil];

}
/**
 选取图片完成的方法

 @param picker 控制器
 @param info 信息
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.drawView.displayImageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/**
 保存的事件

 @param sender 对象本身
 */
- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    // 创建图片上下文
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0.0);
    // 获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    // 写入相册
    UIImageWriteToSavedPhotosAlbum(getImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
  
}

/**
 图片保存方法回调

 @param image 图片
 @param error 错误
 @param contextInfo 上下文
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        NSLog(@"保存成功了");
        
    }
}
/**
 进度条改变的事件

 @param sender 进度条
 */
- (IBAction)sliderChangeAction:(UISlider *)sender {
    
    self.drawView.width = sender.value;
    
}

/**
 按钮点击的事件

 @param sender 按钮
 */
- (IBAction)buttonAction:(UIButton *)sender {
    
    self.drawView.color = sender.backgroundColor;
}



#pragma mark -  其他事件的响应
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
