//
//  DGShowView.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGShowView.h"
#import "DGAnimationView.h"

@implementation DGShowView


static NSMutableDictionary *cacheDic_;
/**
 初始化
 */
+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheDic_ = [NSMutableDictionary dictionary];
    });
}
/**
 在那个控制器的view上显示加载的动画,
 
 @param view view
 */
+ (void)DG_showAnimationView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = view.frame;
        frame.origin.y = 64;
        frame.size.height = view.frame.size.height - 64;
        CGRect obtainFrame = frame;
        // 创建动画的view
        DGAnimationView *animationView = [[[NSBundle mainBundle]loadNibNamed:@"DGAnimationView" owner:nil options:nil] lastObject];
        animationView.frame = obtainFrame;
        [animationView setAnimationType:DGAnimationTypeCommon];
        [view addSubview:animationView];
        // 存储view
        NSString *keyName = [NSString stringWithFormat:@"%zd%p", DGAnimationTypeCommon,view];
        cacheDic_[keyName] = animationView;
    });
}
/**
 在那个view上展示动画
 
 @param animataionType 动画的类型
 @param defaultY 距离顶部的距离
 @param view 在哪个view上显示
 */
+ (void)DG_showAnimationViewWithType:(DGAnimationType)animataionType withDefaultY:(CGFloat)defaultY inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = view.frame;
        frame.origin.y = defaultY;
        frame.size.height = view.frame.size.height - defaultY;
        CGRect obtainFrame = frame;
        // 创建动画的view
        DGAnimationView *animationView = [[[NSBundle mainBundle]loadNibNamed:@"DGAnimationView" owner:nil options:nil] lastObject];
        animationView.frame = obtainFrame;
        [animationView setAnimationType:animataionType];
        [view addSubview:animationView];
        // 存储view
        NSString *keyName = [NSString stringWithFormat:@"%zd%p", animataionType,view];
        cacheDic_[keyName] = animationView;
    });
}
/**
 隐藏在view上的所有的动画
 
 @param view 在哪个view上
 */
+ (void)DG_hideViewInView:(UIView *)view{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *strp = [NSString stringWithFormat:@"%p",view];
        NSMutableArray *temArray = [NSMutableArray array];
        for (NSString *key in cacheDic_.allKeys) {
            if ([key containsString:strp]) {
                [temArray addObject:key];
            }
        }
        for (NSString *keyName in temArray) {
            DGAnimationView *animationView = (DGAnimationView *)cacheDic_[keyName];
            [animationView removeFromSuperview];
            [cacheDic_ removeObjectForKey:keyName];
        }
    });
}
/**
 隐藏在view上的某一种类型的加载动画
 
 @param animataionType 动画的类型
 @param view 在哪个view上
 */
+ (void)DG_hideViewInViewWithType:(DGAnimationType)animataionType inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *keyName = [NSString stringWithFormat:@"%zd%p", animataionType,view];
        if ([cacheDic_.allKeys containsObject:keyName]) {
            DGAnimationView *animationView = (DGAnimationView *)cacheDic_[keyName];
            [animationView removeFromSuperview];
            [cacheDic_ removeObjectForKey:keyName];
        }
    });
}


@end
