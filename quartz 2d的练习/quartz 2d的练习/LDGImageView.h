//
//  LDGImageView.h
//  quartz 2d的练习
//
//  Created by 刘殿阁 on 2018/2/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGImageView : UIView

/** image*/
@property (nonatomic, strong) UIImage *image;
/**
 初始化

 @param image image
 @return 对象本身
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
