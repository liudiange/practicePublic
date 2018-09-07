//
//  DGToastViewObject.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGToastViewObject.h"


#define DGScreen [UIScreen mainScreen].bounds.size
#define DGBottomViewH 64


@implementation DGToastViewObject
/**
 弹出应该有的提示
 
 @param promptStr 提示语
 @param type 类型
 */
+ (void)DG_showToastString:(NSString *)promptStr withType:(DGToastType)type{
    
    if (promptStr.length == 0) return;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 创建一个view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DGScreen.width, DGBottomViewH)];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, DGBottomViewH)];
        iconImageView.contentMode = UIViewContentModeCenter;
        UILabel *promptLable = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width, 0, DGScreen.width - iconImageView.frame.size.width, DGBottomViewH)];
        switch (type) {
            case DGToastTypeFail:
            {
                iconImageView.image = [UIImage imageNamed:@"cxco_mgf_icon_toast_error"];
            }
                break;
            case DGToastTypeSuccess:
            {
                iconImageView.image = [UIImage imageNamed:@"cxco_mgf_icon_toast_success"];
            }
                break;
                
            default:
            {
                
            }
                break;
        }
        promptLable.text = promptStr;
        [bottomView addSubview:promptLable];
        [bottomView addSubview:iconImageView];
        bottomView.backgroundColor = [UIColor greenColor];
        [[UIApplication sharedApplication].delegate.window addSubview:bottomView];
        // 开始显示
        [self showView:bottomView duration:2.0];
        [self addGesture:bottomView];
    }];
}
/**
 弹出应该有的提示
 
 @param promptStr 提示语
 @param type 类型
 @param duration 动画的时间
 */
+ (void)DG_showToastString:(NSString *)promptStr withType:(DGToastType)type withDuration:(NSTimeInterval)duration{
 
    if (promptStr.length == 0) return;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 创建一个view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DGScreen.width, DGBottomViewH)];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, DGBottomViewH)];
        iconImageView.contentMode = UIViewContentModeCenter;
        UILabel *promptLable = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width, 0, DGScreen.width - iconImageView.frame.size.width, DGBottomViewH)];
        switch (type) {
            case DGToastTypeFail:
            {
                iconImageView.image = [UIImage imageNamed:@"cxco_mgf_icon_toast_error"];
            }
                break;
            case DGToastTypeSuccess:
            {
                iconImageView.image = [UIImage imageNamed:@"cxco_mgf_icon_toast_success"];
            }
                break;
                
            default:
            {
                
            }
                break;
        }
        promptLable.text = promptStr;
        [bottomView addSubview:promptLable];
        [bottomView addSubview:iconImageView];
        bottomView.backgroundColor = [UIColor greenColor];
        [[UIApplication sharedApplication].delegate.window addSubview:bottomView];
        // 开始显示
        [self showView:bottomView duration:duration];
        [self addGesture:bottomView];
    }];
    
}
+ (void)addGesture:(UIView *)displayView{
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [displayView addGestureRecognizer:panGes];
}
+ (void)panAction:(UIPanGestureRecognizer *)panGes{
    
    if (panGes.state == UIGestureRecognizerStateEnded) {
        NSLog(@"已经进入了");
         [self hiddenView:panGes.view];
    }
}
+ (void)showView:(UIView *)displayView duration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = displayView.frame;
        frame.origin.y = 0;
        displayView.frame = frame;
    }completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hiddenView:displayView];
        });
    }];
   
}
+(void)hiddenView:(UIView *)displayView{
    if (displayView == nil) return;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = displayView.frame;
        frame.origin.y = -DGBottomViewH;
        displayView.frame = frame;
    }completion:^(BOOL finished) {
        [displayView removeFromSuperview];
    }];
}
@end
