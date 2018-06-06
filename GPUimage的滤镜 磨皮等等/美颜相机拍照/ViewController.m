//
//  ViewController.m
//  美颜相机拍照
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 apple. All rights reserved.
//av

#import "ViewController.h"
#import "GPUImage-umbrella.h"

@interface ViewController ()

@property (weak ,nonatomic) IBOutlet UIImageView *backImageView;

@property (strong, nonatomic) GPUImageStillCamera *camera;
@property (strong, nonatomic) GPUImageBrightnessFilter *sketchFilter;

@end

@implementation ViewController

- (IBAction)saveAction:(UIButton *)sender {
   // capturePhotoAsImageProcessedUp
    
    __weak typeof(self)weakSelf = self;
    [self.camera capturePhotoAsImageProcessedUpToFilter:self.sketchFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        weakSelf.backImageView.image = processedImage;
        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil);
        [weakSelf.camera stopCameraCapture];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个美颜的相机(前至摄像头)
    GPUImageStillCamera *camera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    // 相机的方向
    camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    // 创建滤镜
    GPUImageBrightnessFilter *sketchFilter = [[GPUImageBrightnessFilter alloc] init];
    sketchFilter.brightness = 0.3;
    // 创建一个imageview
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:imageView atIndex:0];
    [sketchFilter addTarget:imageView];
    [camera addTarget:sketchFilter];
    // 开始启动
    [camera startCameraCapture];
    
    self.sketchFilter = sketchFilter;
    self.camera = camera;
}


@end
