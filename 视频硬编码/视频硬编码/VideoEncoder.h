//
//  VideoEncoder.h
//  VideoToolBox
//
//  Created by xiaomage on 2016/11/3.
//  Copyright © 2016年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VideoToolbox/VideoToolbox.h>

@interface VideoEncoder : NSObject

- (void)encodeSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)endEncode;

@end
