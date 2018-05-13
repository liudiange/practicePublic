//
//  UIView+LDGXIBCategory.m
//  ZhiBo
//
//  Created by 刘殿阁 on 2018/5/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIView+LDGXIBCategory.h"

@implementation UIView (LDGXIBCategory)

/**
 xib方式加载
 */
+ (instancetype)loadViewXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
/**
 xib方式加载
 
 @param name 名字
 @return 对象本身
 */
+ (instancetype)loadViewXibName:(NSString *)name{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject];
}
@end
