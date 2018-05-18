
//
//  LDGGiftEmoticonManager.m
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGGiftEmoticonManager.h"

@implementation LDGGiftEmoticonManager

- (instancetype)init {
    if (self = [super init]) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"type"] = @(0);
        paramDic[@"page"] = @(1);
        paramDic[@"rows"] = @(150);
        self.requestMethod = @"get";
        self.requestUrl = @"http://qf.56.com/pay/v4/giftList.ios";
        self.paramDic = paramDic;

    }
    return self;
}

/**
 解析服务器返回的方法

 @param responseDic 返回的字典
 @param complete 完成的block
 */
-(void)parseData:(NSDictionary *)responseDic complete:(void (^)(NSError * _Null_unspecified))complete{
    NSError *error = nil;
    LDGLog(@"responseDic --- %@",responseDic);
    
}
@end
