//
//  LDGImageView.m
//  quartz 2d的练习
//
//  Created by 刘殿阁 on 2018/2/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "LDGImageView.h"

@implementation LDGImageView

-(void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}
/**
 初始化
 
 @param image image
 @return 对象本身
 */
- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self setNeedsDisplay];
    }
    return self;
    
}
- (void)drawRect:(CGRect)rect {
    [self.image drawInRect:rect];
    
}


@end
