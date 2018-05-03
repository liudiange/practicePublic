//
//  LDGHomeServer.m
//  ZhiBo
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGHomeServer.h"
#import <MJExtension/MJExtension.h>

@implementation LDGHomeServer

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

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
        dic[@"index"] = @(0);
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
- (void)parseData:(NSDictionary * __nonnull)responseDic complete:(void (^)(NSError *_Null_unspecified error))complete{
    NSError *error = nil;
    if ([responseDic[@"status"] longLongValue] == 200) {
        self.dataArray = [LDGAuthorModel mj_objectArrayWithKeyValuesArray:responseDic[@"message"][@"anchors"]];
    }else{
        [self.dataArray removeAllObjects];
        error = [NSError errorWithDomain:@"服务器返回错误" code:300 userInfo:nil];
    }
    complete(error);
}

@end
