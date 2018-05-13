//
//  UIView+LDGXIBCategory.h
//  ZhiBo
//
//  Created by 刘殿阁 on 2018/5/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LDGXIBCategory)
/**
 xib方式加载
 */
+ (instancetype)loadViewXib;

/**
 xib方式加载

 @param name 名字
 @return 对象本身
 */
+ (instancetype)loadViewXibName:(NSString *)name;
@end
