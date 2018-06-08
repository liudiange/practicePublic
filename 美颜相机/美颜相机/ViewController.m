//
//  ViewController.m
//  美颜相机
//
//  Created by apple on 2018/6/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage/GPUImage.h>

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
 创建写入的文件
 */
@property (strong, nonatomic) GPUImageMovieWriter *movieWriter;

// 底部的view
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstaton;




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
-(GPUImageMovieWriter *)movieWriter {
    if (!_movieWriter) {
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:[self obtainUrl] size:[UIScreen mainScreen].bounds.size];
    }
    return _movieWriter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化一些滤镜
    self.bilaterFilter = [[GPUImageBilateralFilter alloc] init];
    self.exposureFilter = [[GPUImageExposureFilter alloc] init];
    self.brigtnessFilter = [[GPUImageBrightnessFilter alloc] init];
    self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
    // 调整摄像头的方向
    self.camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    // 调整摄像头的镜像 自己动的方向和镜子中的方向一致
    self.camera.horizontallyMirrorFrontFacingCamera = YES;
    // 创建过滤层
    GPUImageFilterGroup *filterGroup = [self obtainFilterGroup];
    [self.camera addTarget:filterGroup];
    // 将imageview 添加到过滤层上
    [filterGroup addTarget:self.previewLayer];
    [self.view insertSubview:self.previewLayer atIndex:0];
    // 开始拍摄
    [self.camera startCameraCapture];
#pragma mark - 开始写入视频
    self.movieWriter.encodingLiveVideo = YES;
    [filterGroup addTarget:self.movieWriter];
    self.camera.delegate = self;
    self.camera.audioEncodingTarget = self.movieWriter;
    // 开始录制
    [self.movieWriter startRecording];
}

/**
 获取缓存的路径

 @return 获取到自己想要的url
 */
- (NSURL *)obtainUrl{
  
    NSString *pathStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
    NSURL *url = [NSURL fileURLWithPath:pathStr];
    return url;
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
#pragma mark - 相关按钮的点击事件

/**
 结束直播相关的事件

 @param sender 按钮
 */
- (IBAction)endLiveAction:(UIButton *)sender {
    
    
    
}
/**
 开始播放视频

 @param sender 按钮
 */
- (IBAction)startPlayAction:(UIButton *)sender {
    
    
}

/**
 点击弹出需要设备的美颜参数

 @param sender 按钮
 */
- (IBAction)beautufulViewAction:(UIButton *)sender {
    if (self.bottomViewBottomConstaton.constant == -250) {
        self.bottomViewBottomConstaton.constant = 0;
    }else{
        self.bottomViewBottomConstaton.constant = -250;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 切换前后摄像头

 @param sender 按钮
 */
- (IBAction)switchFontAndBehindCameraAction:(UIButton *)sender {
    
    [self.camera rotateCamera];
    
}

/**
 开启或者关闭美颜

 @param sender 按钮
 */
- (IBAction)closeOrOpenBeautifulAction:(UISwitch *)sender {
    if (sender.isOn) {
        [self.camera removeAllTargets];
        GPUImageFilterGroup *group = [self obtainFilterGroup];
        [self.camera addTarget:group];
        [group addTarget:self.previewLayer];
        
    }else{
        [self.camera removeAllTargets];
        [self.camera addTarget:self.previewLayer];
    }
}
/**
 磨皮的slider的事件

 @param sender 按钮
 */
- (IBAction)mopiSliderAction:(UISlider *)sender {
    
    self.bilaterFilter.distanceNormalizationFactor = sender.value * 0.3;
    
}
/**
 曝光的按钮的点击事件

 @param sender 按钮
 */
- (IBAction)baoguangSliderAction:(UISlider *)sender {
    
    self.exposureFilter.exposure = sender.value;
    
}

/**
 美白的按钮的点击事件

 @param sender 按钮
 */
- (IBAction)meibaiSliderAction:(UISlider *)sender {
    
    self.brigtnessFilter.brightness = sender.value;
}

/**
 饱和的按钮的点击事件

 @param sender 按钮
 */
- (IBAction)baoheSliderAction:(UISlider *)sender {
    
    self.saturationFilter.saturation = sender.value;
    
}





@end
