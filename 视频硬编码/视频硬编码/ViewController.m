//
//  ViewController.m
//  视频硬编码
//
//  Created by apple on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoEncoder.h"


@interface ViewController ()<GPUImageVideoCameraDelegate>
// 创建摄像头
@property (strong, nonatomic) GPUImageVideoCamera *camera;
@property (strong, nonatomic) GPUImageView *previewLayer;
// 创建几个滤镜
/**
 摩皮
 */
@property (strong, nonatomic) GPUImageBilateralFilter *bilaterFilter;
/**
 曝光
 */
@property (strong, nonatomic) GPUImageExposureFilter *exposureFilter;
/**
 美白
 */
@property (strong, nonatomic) GPUImageBrightnessFilter *brigtnessFilter;
/**
 饱和
 */
@property (strong, nonatomic) GPUImageSaturationFilter *saturationFilter;
/**
 编码工具
 */
@property (strong, nonatomic) VideoEncoder *videoEncoder;

@end

@implementation ViewController
-(GPUImageVideoCamera *)camera {
    if (!_camera) {
        _camera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    }
    return _camera;
}
-(GPUImageView *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    }
    return _previewLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化编码相关
    self.videoEncoder = [[VideoEncoder alloc] init];
    //初始化一些滤镜
    self.bilaterFilter = [[GPUImageBilateralFilter alloc] init];
    self.exposureFilter = [[GPUImageExposureFilter alloc] init];
    self.brigtnessFilter = [[GPUImageBrightnessFilter alloc] init];
    self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
    // 调整摄像头的方向
//    self.camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    // 设置竖屏 否则露出来的视频 和我们想要的不一样
    self.camera.videoCaptureConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    // 调整摄像头的镜像 自己动的方向和镜子中的方向一致
    self.camera.videoCaptureConnection.videoMirrored = YES;
//    self.camera.horizontallyMirrorFrontFacingCamera = YES;
    // 创建过滤层
    GPUImageFilterGroup *filterGroup = [self obtainFilterGroup];
    [self.camera addTarget:filterGroup];
    // 将imageview 添加到过滤层上
    [filterGroup addTarget:self.previewLayer];
    [self.view insertSubview:self.previewLayer atIndex:0];
    self.camera.delegate = self;
    // 开始拍摄
    [self.camera startCameraCapture];

}
/**
 创建过滤组
 */
- (GPUImageFilterGroup *)obtainFilterGroup{
    
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    // 按照顺序组成一个链
    [self.bilaterFilter addTarget:self.exposureFilter];
    [self.exposureFilter addTarget:self.brigtnessFilter];
    [self.brigtnessFilter addTarget:self.saturationFilter];
    // 将滤镜添加到滤镜组中(开始和结尾)
    group.initialFilters = @[self.bilaterFilter];
    group.terminalFilter = self.saturationFilter;
    
    return group;
}
/**
 结束直播相关的事件
 
 @param sender 按钮
 */
- (IBAction)endLiveAction:(UIButton *)sender {
    
    [self.camera stopCameraCapture];
    [self.previewLayer removeFromSuperview];
    [self.videoEncoder endEncode];
}
#pragma mark - camera 的 delegate

- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    NSLog(@"---------------");
    [self.videoEncoder encodeSampleBuffer:sampleBuffer];
}

@end
