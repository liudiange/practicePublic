//
//  DrawView.h
//  quartz 2d的练习
//
//  Created by apple on 2018/2/26.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

/**
 显示的imageview
 */
@property (nonatomic,weak)IBOutlet UIImageView *displayImageView;
/**
 颜色
 */
@property (strong, nonatomic) UIColor *color;

/**
 宽度
 */
@property (assign, nonatomic) CGFloat width;
/**
  清除的操作
 */
- (void)clearAction;
/**
  撤销的操作
 */
- (void)undoAction;
/**
 橡皮擦的事件
 */
- (void)eraserAction;

@end
