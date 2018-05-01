//
//  LDGHomeServer.m
//  ZhiBo
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeServer.h"

@implementation LDGHomeServer
/**
 根据模型来进行创建

 @param model model
 @return 对象本身
 */
-(instancetype)initWithModel:(LDGHomeModel *)model{
    if (self = [super init]) {
        self.requestUrl = @"http://qf.56.com/home/v4/moreAnchor.ios";
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"type"] = model.type;
        dic[@"index"] = @"index";
        dic[@"size"] = @(48);
        self.paramDic = dic;
        self.requestMethod = @"GET";
    }
    return self;
}
/**
 解析服务器给的数据

 @param responseDic 服务器返沪的字典
 @param complete 返回
 */
- (void)parseData:(NSDictionary *)responseDic complete:(void (^)(NSError * _Null_unspecified))complete{
    
    
    
}

@end
