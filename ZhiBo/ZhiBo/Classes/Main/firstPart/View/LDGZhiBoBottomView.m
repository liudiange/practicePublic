//
//  LDGZhiBoBottomView.m
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGZhiBoBottomView.h"


@interface LDGZhiBoBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *qfstarButton;

@end
@implementation LDGZhiBoBottomView
- (void)awakeFromNib {
    [super awakeFromNib];
    LDGLog(@"开始加载了");
    
}
#pragma mark - 各种按钮的点击事件
/**
 消息按钮的点击事件

 @param sender 按钮
 */
- (IBAction)messageButtonAction:(UIButton *)sender {
    LDGLog(@"点击了消息按钮");
}
/**
 分享按钮的点击事件
 
 @param sender 按钮
 */
- (IBAction)shareButtonAction:(UIButton *)sender {
    LDGLog(@"点击了分享按钮");
}
/**
 礼物按钮的点击事件
 
 @param sender 按钮
 */
- (IBAction)giftButtonAction:(id)sender {
    LDGLog(@"点击了礼物按钮");
}
/**
 更多按钮的点击事件
 
 @param sender 按钮
 */
- (IBAction)moreButtonAction:(UIButton *)sender {
     LDGLog(@"点击了更多按钮");
}
/**
 动画按钮的点击事件
 
 @param sender 按钮
 */
- (IBAction)qfstarButtonAction:(UIButton *)sender {
    LDGLog(@"点击了动画按钮");
    sender.selected = !sender.isSelected;
    sender.selected == YES ? ([LDGCommonTool startEmitterAnimation:CGPointMake(sender.xmg_centerX,self.zhiboVc.view.xmg_height - 0.5 *sender.xmg_centerY) withController:self.zhiboVc]) : ([LDGCommonTool stopEmitterAnimationWithController:self.zhiboVc]);
}


@end
