//
//  UIImage+image.h
//  quartz 2d的练习
//
//  Created by apple on 2018/2/22.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

/**
 裁剪一个图片为圆形
 
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param imageViewWidth 外面的imageview的宽度，如果为0 将按照比例显示不按照正确的显示，如果imageview不是正方形请按照最小的传递
 @param imageName 图片的名字
 @return 想要的图片
 */
+(UIImage *)imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor imageViewWidth:(CGFloat)imageViewWidth imageName:(NSString *)imageName;

@end
