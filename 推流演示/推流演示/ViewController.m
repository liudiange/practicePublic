//
//  ViewController.m
//  推流演示
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <LFLiveKit/LFLiveKit.h>


@interface ViewController ()<LFLiveSessionDelegate>

@property (strong, nonatomic) LFLiveSession *session;


@end

@implementation ViewController
- (LFLiveSession*)session {
    if (!_session) {
        LFLiveVideoConfiguration * liveConfigation = [LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_High2 outputImageOrientation:UIInterfaceOrientationPortrait];
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:liveConfigation];
        _session.preView = self.view;
        _session.delegate = self;
    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self stopLive];
    // 是否需要美颜
    self.session.beautyFace = NO;
    
}
- (IBAction)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    //streamInfo.url = @"rtmp://59.100.27.24/live/demo";
    //rtmp://localhost:1935/rtmplive/home
    streamInfo.url = @"rtmp://localhost:1935/rtmplive/home";
    [self.session startLive:streamInfo];
    self.session.running = YES;
}
- (IBAction)switchCamera:(UIButton *)sender {
    if (self.session.captureDevicePosition == 1) {
        self.session.captureDevicePosition = 2;
    }else{
        self.session.captureDevicePosition = 1;
    }
}

- (IBAction)stopLive {
    [self.session stopLive];
}


- (IBAction)beauty:(UISlider *)sender {
    self.session.beautyLevel = sender.value;
}

- (IBAction)bright:(UISlider *)sender {
    self.session.brightLevel = sender.value;
}
- (IBAction)zoom:(UISlider *)sender {
    self.session.zoomScale = sender.value;
}




#pragma mark - delegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSLog(@"LFLiveState -- %zd",state);
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo{
    NSLog(@"LFLiveDebug -- %@",debugInfo);
}
/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"LFLiveSocketErrorCode -- %zd",errorCode);
}
@end
