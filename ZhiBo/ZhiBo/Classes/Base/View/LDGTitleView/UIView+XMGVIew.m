//
//  UIView+XMGVIew.m
//  百思不得姐
//
//  Created by Connect on 2017/7/25.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UIView+XMGVIew.h"

@implementation UIView (XMGVIew)
-(void)setXmg_left:(CGFloat)xmg_left{
    CGRect rect = self.frame;
    rect.origin.x = xmg_left;
    self.frame = rect;
}
- (CGFloat)xmg_left{
    return self.frame.origin.x;
}
- (void)setXmg_right:(CGFloat)xmg_right{
    CGRect rect = self.frame;
    rect.origin.x = xmg_right- rect.size.width;
    self.frame = rect;
}
- (CGFloat)xmg_right {
    return self.frame.origin.x + self.frame.size.width;
}
-(void)setXmg_top:(CGFloat)xmg_top {
    CGRect rect = self.frame;
    rect.origin.y = xmg_top;
    self.frame = rect;
}
-(CGFloat)xmg_top{
    return self.frame.origin.y;
}
-(void)setXmg_bottom:(CGFloat)xmg_bottom {
    CGRect rect = self.frame;
    rect.origin.y = xmg_bottom - rect.size.height;
    self.frame = rect;
}
-(CGFloat)xmg_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setXmg_width:(CGFloat)xmg_width {
    CGRect rect = self.frame;
    rect.size.width = xmg_width;
    self.frame = rect;
}
- (CGFloat)xmg_width {
    return self.frame.size.width;
}
-(void)setXmg_height:(CGFloat)xmg_height {
    CGRect rect = self.frame;
    rect.size.height = xmg_height;
    self.frame = rect;
}
- (CGFloat)xmg_height {
    return self.frame.size.height;
}

-(void)setXmg_centerX:(CGFloat)xmg_centerX {
    CGPoint center = self.center;
    center.x = xmg_centerX;
    self.center = center;
}
-(CGFloat)xmg_centerX {
    return  self.center.x;
}
-(void)setXmg_centerY:(CGFloat)xmg_centerY {
    CGPoint center = self.center;
    center.y = xmg_centerY;
    self.center = center;
}
-(CGFloat)xmg_centerY {
    return  self.center.y;
}
- (void)setXmg_size:(CGSize)xmg_size {
    CGRect rect = self.frame;
    rect.size = xmg_size;
    self.frame = rect;
}
- (CGSize)xmg_size {
    return self.frame.size;
}
/**
 *
 *  加载xib
 */
+ (instancetype)xmg_viewFromXib {
    
   return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    
}

@end
