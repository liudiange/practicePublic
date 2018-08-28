//
//  FirstViewController.m
//  同时来多个数据的时候处理tableview
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FirstViewController.h"
#import "DGShareInfo.h"


@interface FirstViewController ()


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTimer];
    
    
}
/**
 添加定时器
 */
-(void)addTimer{

    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"ding shi qi run");

        [[DGShareInfo shareInfo].dataArray removeAllObjects];

        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (NSInteger index = 0; index < 20; index++) {

                [[DGShareInfo shareInfo].dataArray addObject:@"test"];

            }
        });
         [[NSNotificationCenter defaultCenter] postNotificationName:@"arrayChange" object:nil];
       
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}
@end
