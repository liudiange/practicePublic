//
//  DGShareInfo.h
//  同时来多个数据的时候处理tableview
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGShareInfo : NSObject

/**
 单利对象

 @return 返回对象本身
 */
+(instancetype)shareInfo;
/**
 数组
 */
@property (strong, nonatomic) NSMutableArray *dataArray;
/**
数组安全的锁，其他慎用
 */
@property (strong, nonatomic) NSLock *dataLock;





@end
