//
//  LDGDisplayView.m
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGDisplayView.h"
#import "LDGChannelView.h"

@interface LDGDisplayView ()<LDGChannelViewDelegate>
/**
 缓存的模型
 */
@property (strong, nonatomic) NSMutableArray *cacheModelArray;

@end


@implementation LDGDisplayView
-(NSMutableArray *)cacheModelArray {
    if (!_cacheModelArray) {
        _cacheModelArray = [[NSMutableArray alloc] init];
    }
    return _cacheModelArray;
}
/**
 快捷方式创建
 
 @param frame frame
 @param channnelCount 个数
 @return 对象本身
 */
-(instancetype)initWithFrame:(CGRect)frame withChannnelCount:(NSInteger )channnelCount{
    if (self = [super initWithFrame:frame]) {
        CGFloat channelHeight = 50.0;
        CGFloat channelMargon = 10.0;
        for (NSInteger index = 0; index < channnelCount; index++) {
            LDGChannelView *channelView = [LDGChannelView ChannelloadFromXib];
            channelView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, index * (channelHeight + channelMargon), self.frame.size.width, (channelHeight + channelMargon));
            channelView.alpha = 1.0;
            channelView.channelDelegate = self;
            [self addSubview:channelView];
        }
    }
    return self;
}
/**
 开始展示数据
 
 @param giftModel 礼物的模型
 */
- (void)showGift:(LDGGiftModel *)giftModel{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 判断是否有闲置的
        NSInteger indexNumber = -1;
        for (NSInteger index = 0; index < self.subviews.count; index ++) {
            LDGChannelView *channelView = self.subviews[index];
            if ([channelView.model isEqualsModel:giftModel] && (channelView.currentState != CurrentStateHaveEndAnimation)){// 同一个人送的同一个礼物
                // 添加缓存
                [channelView addCacheNumber];
                indexNumber = index;
                break;
            }
            
            if (channelView.currentState == CurrentStateIdle) { // 闲置的
                [channelView showChannelModel:giftModel];
                indexNumber = index;
                break;
            }
        }
        // 说明 没有闲置的 也不是同一个人送的同一个礼物
        if (indexNumber == -1) {
            [self.cacheModelArray addObject:giftModel];
        }
    });
}
#pragma mark - delegate 回调用
/**
 channnleView已经完成了动画
 
 @param channelView channelview
 */
- (void)channelIsFinishAnimation:(LDGChannelView *)channelView{
    if (self.cacheModelArray.count) {
        for (NSInteger index = self.cacheModelArray.count -1; index >= 0; index -- ) {
            LDGGiftModel *giftModel = self.cacheModelArray[index];
            // 判断是否有闲置的
            NSInteger indexNumber = -1;
            for (NSInteger index = 0; index < self.subviews.count; index ++) {
                LDGChannelView *channelView = self.subviews[index];
                if ([channelView.model isEqualsModel:giftModel] && (channelView.currentState != CurrentStateHaveEndAnimation)){// 同一个人送的同一个礼物
                    // 添加缓存
                    [channelView addCacheNumber];
                    [self.cacheModelArray removeLastObject];
                    indexNumber = index;
                    break;
                }
                
                if (channelView.currentState == CurrentStateIdle) { // 闲置的
                    [channelView showChannelModel:giftModel];
                    [self.cacheModelArray removeLastObject];
                    indexNumber = index;
                    break;
                }
            }
        }
    }
}

@end
