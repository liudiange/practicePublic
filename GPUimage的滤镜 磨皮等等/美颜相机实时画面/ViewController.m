//
//  ViewController.m
//  美颜相机实时画面
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage-umbrella.h"

@interface ViewController ()<GPUImageVideoCameraDelegate>

@property (strong, nonatomic) GPUImageStillCamera *stillCamera;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GPUImageStillCamera *stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    // 设置方向
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    GPUImageBrightnessFilter *brightNessFilter = [[GPUImageBrightnessFilter alloc] init];
    brightNessFilter.brightness = 0.45;
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view insertSubview:imageView atIndex:0];
    // 将imageview 添加到 brightNessFilter
    [brightNessFilter addTarget:imageView];
    // 将brightNessFilter 添加到相机上
    [stillCamera addTarget:brightNessFilter];
    // 开始采集
    [stillCamera startCameraCapture];
     stillCamera.delegate = self;
    // 这个是设置镜像的 自己脸动的方向和 手机方向一致
    stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.stillCamera = stillCamera;

}
#pragma mark delegate
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    NSLog(@"已经输出每一帧的画面了");
}

@end
