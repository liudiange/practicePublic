//
//  ViewController.m
//  GPUimage的滤镜 磨皮等等
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage-umbrella.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;


@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}

/**
 褐色的按钮的点击事件

 @param sender 阿牛
 */
- (IBAction)brownAction:(UIButton *)sender {
    
    self.displayImageView.image = [UIImage imageNamed:@"test"];
    GPUImageSepiaFilter *brownFilter = [[GPUImageSepiaFilter alloc] init];
    // 设置渲染区域
    [brownFilter forceProcessingAtSize:self.displayImageView.image.size];
    [brownFilter useNextFrameForImageCapture];
    // 创建数据源
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
    // 将滤镜添加到数据源上
    [imageSource addTarget:brownFilter];
    // 开始渲染
    [imageSource processImage];
    // 生成新的图片
    UIImage *image = [brownFilter imageFromCurrentFramebuffer];
    self.displayImageView.image = image;
    
    
//    self.displayImageView.image = [UIImage imageNamed:@"test"];
//    // 添加黑白素描滤镜
//    GPUImageSketchFilter *stillFilter = [[GPUImageSketchFilter alloc] init];
//    // 设置渲染区域
//    [stillFilter forceProcessingAtSize:self.displayImageView.image.size];
//    [stillFilter useNextFrameForImageCapture];
//    // 获取数据源
//    GPUImagePicture *stilImageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
//    // 添加滤镜
//    [stilImageSource addTarget:stillFilter];
//    // 开始渲染
//    [stilImageSource processImage];
//    // 生成新的图片
//    UIImage *newImage = [stillFilter imageFromCurrentFramebuffer];
//    self.displayImageView.image = newImage;
    
}
/**
 卡通的事件

 @param sender 按钮
 */
- (IBAction)cartoon:(UIButton *)sender {
    
    self.displayImageView.image = [UIImage imageNamed:@"test"];
    GPUImageToonFilter *cartoolFilter = [[GPUImageToonFilter alloc] init];
    // 创建数据源
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
    // 设置渲染区域
    [cartoolFilter forceProcessingAtSize:self.displayImageView.image.size];
    [cartoolFilter useNextFrameForImageCapture];
    // 将滤镜添加到数据源上
    [imageSource addTarget:cartoolFilter];
    // 开始渲染
    [imageSource processImage];
    // 生成新的图片
    UIImage *image = [cartoolFilter imageFromCurrentFramebuffer];
    self.displayImageView.image = image;

    
}
/**
 素描的事件

 @param sender 按钮
 */
- (IBAction)sketch:(UIButton *)sender {
    
    self.displayImageView.image = [UIImage imageNamed:@"test"];
    GPUImageSketchFilter *sketchFileter = [[GPUImageSketchFilter alloc] init];
    [self filterImage:sketchFileter];
    
    
}

/**
 浮雕的事件

 @param sender 按钮
 */
- (IBAction)reliefAction:(UIButton *)sender {
    
    self.displayImageView.image = [UIImage imageNamed:@"test"];
    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
    // 设置渲染区域
    [embossFilter forceProcessingAtSize:self.displayImageView.image.size];
    [embossFilter useNextFrameForImageCapture];
    // 创建数据源
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
    // 将滤镜添加到数据源上
    [imageSource addTarget:embossFilter];
    // 开始渲染
    [imageSource processImage];
    // 生成新的图片
    UIImage *image = [embossFilter imageFromCurrentFramebuffer];
    self.displayImageView.image = image;
}

- (UIImage *)filterImage:(GPUImageSobelEdgeDetectionFilter *)filter {
    
    // 创建数据源
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
    // 设置渲染区域
    [filter forceProcessingAtSize:self.displayImageView.image.size];
    [filter useNextFrameForImageCapture];
    // 将滤镜添加到数据源上
    [imageSource addTarget:filter];
    // 开始渲染
    [imageSource processImage];
    // 生成新的图片
    UIImage *image = [filter imageFromCurrentFramebuffer];
    return image;
}
/**
 创建一个黑白的素描的图片
 */
- (void)createSketchImage {
   
    
    self.displayImageView.image = [UIImage imageNamed:@"test"];
    // 添加黑白素描滤镜
    GPUImageSketchFilter *stillFilter = [[GPUImageSketchFilter alloc] init];
    // 设置渲染区域
    [stillFilter forceProcessingAtSize:self.displayImageView.image.size];
    [stillFilter useNextFrameForImageCapture];
    // 获取数据源
    GPUImagePicture *stilImageSource = [[GPUImagePicture alloc] initWithImage:self.displayImageView.image];
    // 添加滤镜
    [stilImageSource addTarget:stillFilter];
    // 开始渲染
    [stilImageSource processImage];
    // 生成新的图片
    UIImage *newImage = [stillFilter imageFromCurrentFramebuffer];
    self.displayImageView.image = newImage;
}

@end
