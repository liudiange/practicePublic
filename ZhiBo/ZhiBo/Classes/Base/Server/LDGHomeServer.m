//
//  LDGHomeServer.m
//  ZhiBo
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeServer.h"

@implementation LDGHomeServer

-(instancetype)init{
    if (self = [super init]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        
        self.requestUrl = @"";
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
