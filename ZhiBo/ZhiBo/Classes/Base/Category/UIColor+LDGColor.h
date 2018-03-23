//
//  UIColor+LDGColor.h
//  ZhiBo
//
//  Created by apple on 2018/3/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LDGColor)
/**
 16进制转换颜色
 
 @param herStx herStx
 @return 对象本身
 */
- (instancetype)colorWithHex:(NSString *)herStx;
@end
