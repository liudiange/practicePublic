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
    [self.zhiboVc.messageView.messsageTextField becomeFirstResponder];
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
    [UIView animateWithDuration:0.25 animations:^{
        self.zhiboVc.giftEmoticomView.xmg_top = ScreenHeight - GIFT_VIEW_HEIGHT;
    }];
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
    sender.selected = !sender.isSelected;
    sender.selected == YES ? ([LDGCommonTool startEmitterAnimation:CGPointMake(sender.xmg_centerX,self.zhiboVc.view.xmg_height - 0.5 *sender.xmg_centerY) withController:self.zhiboVc]) : ([LDGCommonTool stopEmitterAnimationWithController:self.zhiboVc]);
}


@end
