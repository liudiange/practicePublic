//
//  DGShowView.h
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DGAnimationType) {
    DGAnimationTypeCommon = 0, // 这个就是我们的默认的模式
    DGAnimationType1      = 1, // 如果后来想要扩展那么应该加设置此类型
    DGAnimationType2      = 2  // 如果后来想要扩展那么应该加设置此类型
};

@interface DGShowView : NSObject

/**
 在那个控制器的view上显示加载的动画,默认的类型、距离顶部64

 @param view view
 */
+ (void)DG_showAnimationView:(UIView *)view;
/**
 在那个view上展示动画

 @param animataionType 动画的类型
 @param defaultY 距离顶部的距离
 @param view 在哪个view上显示
 */
+ (void)DG_showAnimationViewWithType:(DGAnimationType)animataionType withDefaultY:(CGFloat)defaultY inView:(UIView *)view;

/**
 隐藏在view上的所有的动画

 @param view 在哪个view上
 */
+ (void)DG_hideViewInView:(UIView *)view;
/**
 隐藏在view上的某一种类型的加载动画

 @param animataionType 动画的类型
 @param view 在哪个view上
 */
+ (void)DG_hideViewInViewWithType:(DGAnimationType)animataionType inView:(UIView *)view;


@end
