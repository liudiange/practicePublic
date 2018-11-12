//
//  ViewController.m
//  播放器sdk
//
//  Created by apple on 2018/11/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DGMusicManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[DGMusicManager shareInstance] currentPlayMode] == DGPlayerStatusPlay) {
        NSLog(@"asdasdasd");
    }
}


@end
