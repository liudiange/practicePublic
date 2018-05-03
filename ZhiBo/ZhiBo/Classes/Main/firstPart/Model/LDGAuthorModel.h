//
//  LDGAuthorModel.h
//  ZhiBo
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGAuthorModel : NSObject
/**
 房间号
 */
@property (assign, nonatomic) int roomid;
/**
 主播的名字
 */
@property (copy, nonatomic) NSString *name;
/**
 背景图片小图片
 */
@property (copy, nonatomic) NSString *pic51;
/**
 背景图片大图片
 */
@property (copy, nonatomic) NSString *pic74;
/**
 是否在直播
 */
@property (assign, nonatomic) int live;
/**
 直播的显示方式
 */
@property (assign, nonatomic) int push;
/**
 关注数
 */
@property (assign, nonatomic) int focus;

@end
