//
//  LDGDisplayView.h
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGGiftModel.h"


@interface LDGDisplayView : UIView

/**
 快捷方式创建

 @param frame frame
 @param channnelCount 个数
 @return 对象本身
 */
-(instancetype)initWithFrame:(CGRect)frame withChannnelCount:(NSInteger )channnelCount;

/**
 最大显示channnel的个数
 */
@property (assign, nonatomic) NSInteger channnelCount;
/**
 开始展示数据

 @param giftModel 礼物的模型
 */
- (void)showGift:(LDGGiftModel *)giftModel;



@end
