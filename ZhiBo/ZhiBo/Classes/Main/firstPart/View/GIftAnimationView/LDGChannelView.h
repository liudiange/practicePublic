//
//  LDGChannelView.h
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGGiftModel.h"

@class LDGChannelView;
typedef NS_ENUM(NSUInteger,CurrentState) {
    CurrentStateIdle = 0,//  闲置的状态
    CurrentStateAnimationing = 1,//  将要执行动画
    CurrentStateWillEndAnimation = 2,//  正在执行点击动画
    CurrentStateHaveEndAnimation = 4//  将要结束动画
};

@protocol LDGChannelViewDelegate<NSObject>

/**
 channnleView已经完成了动画

 @param channelView channelview
 */
- (void)channelIsFinishAnimation:(LDGChannelView *)channelView;

@end

@interface LDGChannelView : UIView
@property (weak, nonatomic) id<LDGChannelViewDelegate> channelDelegate;
/**
 当前的状态
 */
@property (assign, nonatomic) CurrentState currentState;
#pragma mark - 方法显示
@property (strong, nonatomic) LDGGiftModel *model;
/**
 展示model

 @param model model
 */
- (void)showChannelModel:(LDGGiftModel *)model;
/**
 添加缓存 必须是同一个人，同一个礼物
 */
- (void)addCacheNumber;
/**
 创建xib的文件
 */
+ (instancetype)ChannelloadFromXib;




@end
