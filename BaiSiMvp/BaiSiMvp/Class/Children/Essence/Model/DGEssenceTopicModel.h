//
//  DGEssenceTopicModel.h
//  BaiSiMvp
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGEssenceTopicProtocol.h"
#import "DGBaseHttpManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGEssenceTopicModel : NSObject
/**
 获取首页的每一页数据
 
 @param type 类型
 @param complete 完成的实现
 */
-(void)requestWithType:(DGTopicType)type complete:(void(^) (DGBaseHttpModel *model))complete;

@end

NS_ASSUME_NONNULL_END
