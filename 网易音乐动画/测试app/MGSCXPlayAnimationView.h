//
//  MGSCXPlayAnimationView.h
//  MiguSoundCXCo
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGSCXPlayAnimationView : UIView
/**
 动画的运行速度（范围是0-1，默认是0.75）
 */
@property (assign, nonatomic) CGFloat animation_Speed;
/**
 动画的颜色（默认是红色）
 */
@property (strong, nonatomic) UIColor *animation_Color;
/**
  每一个线条的宽度（如果整个的宽度小于一个线条的宽度，则显示一个，如果不够两个则显示一个以此类推）
 */
@property (assign, nonatomic) CGFloat animation_PerWith;
/**
 显示的个数(默认是4）
 */
@property (assign, nonatomic) int animation_count;

/**
 开始动画
 */
- (void)startAnimation;
/**
 结束动画
 */
- (void)stopAnimation;




@end
