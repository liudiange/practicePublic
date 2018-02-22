//
//  UIImage+image.m
//  quartz 2d的练习
//
//  Created by apple on 2018/2/22.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

/**
 裁剪一个图片为圆形
 
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param imageViewWidth 外面的imageview的宽度，如果为0 将按照比例显示不按照正确的显示，如果imageview不是正方形请按照最小的传递
 @param imageName 图片的名字
 @return 想要的图片
 */
+(UIImage *)imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor imageViewWidth:(CGFloat)imageViewWidth imageName:(NSString *)imageName {
    
    if (imageName.length == 0) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    imageWidth < imageHeight ? (imageHeight = imageWidth) : (imageWidth = imageHeight);
    // 这里为了精确显示传入进来的borderwidth，计算比例
    if (imageViewWidth > 0) {
        CGFloat scale = 1.0 * (imageWidth + 2*borderWidth)/imageViewWidth;
        if (scale < 1.0) {
            scale = 1.0 * imageWidth/imageViewWidth;
        }
        borderWidth = scale * borderWidth;
    }
    // 创建图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth + 2*borderWidth, imageHeight + 2*borderWidth), NO, 0.0);
    // 创建外面的大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWidth + 2*borderWidth, imageHeight + 2*borderWidth)];
    // 绘制颜色
    [borderColor set];
    // 填写
    [path fill];
    // 创建小圆
    CGRect rect = CGRectMake(borderWidth, borderWidth, imageWidth, imageHeight);
    path = [UIBezierPath bezierPathWithOvalInRect:rect];
    // 添加裁剪
    [path addClip];
    // 图片绘制
    [image drawInRect:rect];
    // 获取新的图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return getImage;
}
@end
