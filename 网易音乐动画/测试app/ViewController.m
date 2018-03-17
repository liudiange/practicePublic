//
//  ViewController.m
//  测试app
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MGSCXPlayAnimationView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGSCXPlayAnimationView *playView = [[MGSCXPlayAnimationView alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
    playView.backgroundColor = [UIColor clearColor];
    playView.animation_Color = [UIColor greenColor];
    playView.animation_Speed = 0.7;
    playView.animation_PerWith = 3;
    playView.animation_count = 4;
    [playView startAnimation];
    [self.view addSubview:playView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [playView stopAnimation];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(18.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [playView startAnimation];
    });;

}


@end
