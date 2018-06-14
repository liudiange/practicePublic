//
//  VideoCapture.h
//  VideoToolBox
//
//  Created by xiaomage on 2016/11/3.
//  Copyright © 2016年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCapture : NSObject

- (void)startCapture:(UIView *)preview;

- (void)stopCapture;

@end
