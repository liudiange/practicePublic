
//
//  DGEssenceTopicModel.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssenceTopicModel.h"

@implementation DGEssenceTopicModel
/**
 获取首页的每一页数据
 
 @param type 类型
 @param complete 完成的实现
 */
-(void)requestWithType:(DGTopicType)type complete:(void (^)(DGBaseHttpModel * _Nonnull))complete{

    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"a"] = @"list";
    parma[@"c"] = @"data";
    parma[@"type"] = @(type);
    
    DGBaseHttpManager *manager = [[DGBaseHttpManager alloc] init];
    [manager GETWithRequestUrl:@"http://api.budejie.com/api/api_open.php" param:parma complete:^(DGBaseHttpModel *baseModel) {
        complete(baseModel);
    }];
    
    
}

@end
