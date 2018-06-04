//
//  ViewController.m
//  视频的采集、切换摄像头、保存本地沙河
//
//  Created by apple on 2018/6/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureFileOutputRecordingDelegate>

/**
 管理者
 */
@property (strong, nonatomic) AVCaptureSession *session;
/**
 音频的输入、输出
 */
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
/**
 视频输出
 */
@property (strong, nonatomic) AVCaptureVideoDataOutput *videoOutput;
/**
 视频的文件的写入
 */
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOut;


/**
 预览涂层
 */
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;



@end

@implementation ViewController
-(AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AVAuthorizationStatusNotDetermined = 0,
//    AVAuthorizationStatusRestricted    = 1,
//    AVAuthorizationStatusDenied        = 2,
//    AVAuthorizationStatusAuthorized    = 3,
    // 先获取权限
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
        case AVAuthorizationStatusAuthorized:
            {
                [self initVideoAndAudio];
            }
            break;
        case AVAuthorizationStatusNotDetermined:// 没有选择直接退出app 再次进入直接提示
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self initVideoAndAudio];
                }else{
                    NSLog(@"这个用户脑袋有病，没有给出同意");
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:{ // 这种情况可能开始同意来 ，后来自己又到设置里边给关了
            
        }
        case AVAuthorizationStatusDenied:{ // 明确拒绝了
            
        }
        default:
            break;
    }
}

/**
 初始化音视频的输出 等等的操作
 */
- (void)initVideoAndAudio{
    // 设置分辨率
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    [self.session beginConfiguration];
    
    // 初始化视频的输入和输出
    [self setUpVideoInputOutput];
    // 初始化音频的输入和输出
    [self setUpAudioInputOutput];
    
    [self.session commitConfiguration];
}
/**
 初始化视频的输入和输出
 */
- (void)setUpVideoInputOutput {
    
    // 设备
    AVCaptureDevice *videoDevice = [self captureDevice:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionFront];
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:nil];
    // 输出
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    // 添加输入输出
    [self addInput:videoInput addOutput:videoOutput];
    self.videoInput = videoInput;
    self.videoOutput = videoOutput;

}
/**
 初始化音频的输入输出
 */
- (void)setUpAudioInputOutput{
    // 设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    // 输入
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];
    // 输出
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    [audioOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    // 添加输入输出
    [self addInput:audioInput addOutput:audioOutput];
}

/**
 创建预览涂层
 */
- (void)setUpPreviewLayer{
    // 创建预览涂层
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
}

/**
 开始写入视频到本地
 */
- (void)startRecordVideo{
    
    // 设置输出
    [self.session removeOutput:self.movieFileOut];
    AVCaptureMovieFileOutput *movieFileOut = [[AVCaptureMovieFileOutput alloc] init];
    self.movieFileOut = movieFileOut;
    // 设置connnection
    AVCaptureConnection *connection = [self.movieFileOut connectionWithMediaType:AVMediaTypeVideo];
    connection.automaticallyAdjustsVideoMirroring = YES;
    
    if ([self.session canAddOutput:self.movieFileOut]) {
        [self.session addOutput:self.movieFileOut];
    }
    // 开始录制设置delegate
    NSString *pathStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
    NSURL *pathUrl = [NSURL fileURLWithPath:pathStr];
    [self.movieFileOut startRecordingToOutputFileURL:pathUrl recordingDelegate:self];
    
    
}
/**
 添加输入和输出

 @param input input
 @param output output
 */
- (void)addInput:(AVCaptureDeviceInput *)input addOutput:(AVCaptureOutput *)output{
    if([self.session canAddInput:input]){
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
}
/**
 创建capturedevice

 @param mediaType 类型
 @param position 位置
 @return 返回对象本身
 */
- (AVCaptureDevice *)captureDevice:(AVMediaType)mediaType preferringPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = devices.firstObject;
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            captureDevice = device;
        }
    }
    return captureDevice;
}


#pragma mark - 一些其他方法的响应 主要是点击事件的响应
/**
 开始采集
 */
- (IBAction)startCollection {
    // 开始采集
    [self.session startRunning];
    [self setUpPreviewLayer];
    // 开始录制
    [self startRecordVideo];
}
/**
 停止采集
 */
- (IBAction)stopCollection {
    
    [self.session stopRunning];
    if (self.previewLayer) {
     [self.previewLayer removeFromSuperlayer];
    }
}
/**
 保存到沙河
 */
- (IBAction)rotateDevice {
    // 先拿到之前的旋转摄像头
    if (!self.videoInput) {
        return;
    }
    AVCaptureDeviceInput *obtainInput;
    if (self.videoInput.device.position == AVCaptureDevicePositionFront) {
      AVCaptureDevice *device = [self captureDevice:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
      obtainInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    }else{
      AVCaptureDevice *device = [self captureDevice:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionFront];
      obtainInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    }
    [self.session removeInput:self.videoInput];
    if ([self.session canAddInput:obtainInput]) {
        [self.session addInput:obtainInput];
    }
    self.videoInput = obtainInput;

}
#pragma mark - delegate 的相关的事件

/**
 视频和音频的采集都经过这个方法

 @param output 输出
 @param sampleBuffer 每一帧
 @param connection 链接
 */
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
  
    AVCaptureConnection *obtainConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    if (obtainConnection == connection) {
        NSLog(@"开始采集视频了");
    }else{
        NSLog(@"音频");
    }
}
#pragma mark 录制的想干的delegate
- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections{
    NSLog(@"开始录制");
}
- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error{
    NSLog(@"暂停录制");
}




@end
