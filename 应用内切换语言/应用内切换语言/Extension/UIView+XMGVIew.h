//
//  UIView+XMGVIew.h
//  百思不得姐
//
//  Created by Connect on 2017/7/25.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGVIew)

@property(nonatomic, assign) CGFloat xmg_left;
@property(nonatomic, assign) CGFloat xmg_right;
@property(nonatomic, assign) CGFloat xmg_top;
@property(nonatomic, assign) CGFloat xmg_bottom;
@property(nonatomic, assign) CGFloat xmg_centerX;
@property(nonatomic, assign) CGFloat xmg_centerY;
@property(nonatomic, assign) CGFloat xmg_width;
@property(nonatomic, assign) CGFloat xmg_height;
@property(nonatomic, assign) CGSize xmg_size;
/**
 *
 *  加载xib
 */
+(instancetype)xmg_viewFromXib;

@end
