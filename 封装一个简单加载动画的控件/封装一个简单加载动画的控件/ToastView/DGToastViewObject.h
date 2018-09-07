//
//  DGToastViewObject.h
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DGToastType) {
    DGToastTypeSuccess = 0,
    DGToastTypeFail    = 1
};
@interface DGToastViewObject : NSObject
/**
 弹出应该有的提示

 @param promptStr 提示语
 @param type 类型
 */
+ (void)DG_showToastString:(NSString *)promptStr withType:(DGToastType)type;
/**
 弹出应该有的提示
 
 @param promptStr 提示语
 @param type 类型
 @param duration 动画的时间
 */
+ (void)DG_showToastString:(NSString *)promptStr withType:(DGToastType)type withDuration:(NSTimeInterval)duration;



@end
