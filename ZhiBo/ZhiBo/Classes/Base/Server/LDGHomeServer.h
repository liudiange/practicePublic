//
//  LDGHomeServer.h
//  ZhiBo
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XMGHttpBaseManager.h"
#import "LDGHomeModel.h"
#import "LDGShopModel.h"

@interface LDGHomeServer : XMGHttpBaseManager
/**
 数组
 */
@property (strong, nonatomic) NSMutableArray <LDGShopModel *>*dataArray;
/**
 创建方法

 @param model model
 @return 对象本身
 */
- (instancetype)initWithModel:(LDGHomeModel *)model;





@end
