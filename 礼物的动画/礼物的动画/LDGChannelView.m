//
//  LDGChannelView.m
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGChannelView.h"
#import "UIImageView+WebCache.h"
#import "UIView+XMGVIew.h"
#import "LDGAnimationLable.h"

@interface LDGChannelView ()

@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (weak, nonatomic) IBOutlet UILabel *sendNameLable;
@property (weak, nonatomic) IBOutlet UILabel *sendMessageLable;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet LDGAnimationLable *clickAnimationLable;
/**
 缓存的个数（同一个人 同一个礼物）
 */
@property (assign, nonatomic) NSInteger lableCount;
/**
 当前lable显示的个数
 */
@property (assign, nonatomic) NSInteger currentLableCount;

@end

@implementation LDGChannelView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.lableCount = 1;
    self.currentLableCount = 0;
    self.currentState = CurrentStateIdle;
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.sendImageView.layer.cornerRadius = self.sendImageView.frame.size.width *0.5;
    self.sendImageView.layer.masksToBounds = YES;
    
}
/**
 创建xib的文件
 */
+ (instancetype)ChannelloadFromXib{
   return [[[NSBundle mainBundle] loadNibNamed:@"LDGChannelView" owner:nil options:nil] lastObject];
}
/**
 展示model
 
 @param model model
 */
- (void)showChannelModel:(LDGGiftModel *)model{
    
    self.model = model;
    [self.sendImageView sd_setImageWithURL:[NSURL URLWithString:_model.senderIconUrl]];
    self.sendNameLable.text = model.senderName;
    self.sendMessageLable.text = [NSString stringWithFormat:@"送出礼物：%@",model.giftName];
    [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:model.giftUrl]];
    
    self.currentState = CurrentStateIdle;
    // 开始动画
    [self startAnimation];
}
#pragma mark - 其他时间的响应
/**
 添加缓存 必须是同一个人，同一个礼物
 */
- (void)addCacheNumber{
    self.lableCount += 1;
}
#pragma mark - 动画的相关的时间

/**
 开始动画
 */
- (void)startAnimation{
    self.currentState = CurrentStateWillAnimation;
    [UIView animateWithDuration:0.25 animations:^{
        self.xmg_left = 0;
    } completion:^(BOOL finished) {
        [self startLableAction];
    }];
}

/**
 lable 相关的事件
 */
- (void)startLableAction {
    
    self.currentState = CurrentStateAnimationing;
    
    self.currentLableCount += 1;
    self.clickAnimationLable.text = [NSString stringWithFormat:@"x%zd",self.currentLableCount];
    __weak typeof(self)weakSelf = self;
    [self.clickAnimationLable startAnimation:^(BOOL isFinish) {
        weakSelf.lableCount -= 1;
        if (isFinish) {
            if (weakSelf.lableCount > 0) {
                [weakSelf startLableAction];
            }else{
                [weakSelf performSelector:@selector(finishAnimation) withObject:nil afterDelay:3.0];
            }
        }
    }];
}
/**
 完成动画了
 */
- (void)finishAnimation{
    
    self.currentState = CurrentStateWillEndAnimation;
    [UIView animateWithDuration:0.25 animations:^{
        self.xmg_left = [UIScreen mainScreen].bounds.size.width;
        self.alpha = 0;
    }completion:^(BOOL finished) {
        self.currentLableCount = 0;
        self.currentState = CurrentStateIdle;
        self.lableCount = 1;
        self.model = nil;
        self.xmg_left = -[UIScreen mainScreen].bounds.size.width;
        self.alpha = 1;
        // 执行完了代理回去调用
        if ([self.channelDelegate respondsToSelector:@selector(channelIsFinishAnimation:)]) {
            [self.channelDelegate channelIsFinishAnimation:self];
        }
    }];
}

@end
