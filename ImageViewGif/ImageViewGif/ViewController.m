//
//  ViewController.m
//  ImageViewGif
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *path = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)path, nil);
    size_t count = CGImageSourceGetCount(gifSource);
    NSMutableArray *imagesArray = [NSMutableArray array];
    double totalTime = 0.0;
    for (size_t index = 0; index < count; index++) {
        // 取出图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, index, nil);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [imagesArray addObject:image];
        // 取出每一个图片的时间
        CFDictionaryRef properties =  CGImageSourceCopyPropertiesAtIndex(gifSource, index, nil);
        CFDictionaryRef dic = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        NSDictionary *needDic = (__bridge NSDictionary *)(dic);
        double time = [needDic[@"DelayTime"] doubleValue];
        totalTime += time;
    }
    self.imageView.animationImages = imagesArray.copy;
    self.imageView.animationDuration = totalTime;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];
    
}


@end
