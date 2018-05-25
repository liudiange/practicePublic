
//
//  LDGGiftEmoticonManager.m
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGGiftEmoticonManager.h"
#import "LDGGiftEmoticonModel.h"
#import <MJExtension/MJExtension.h>



@implementation LDGGiftEmoticonManager
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
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
    if ([responseDic[@"status"] longValue] == 200) {
        NSMutableDictionary *dic = [responseDic[@"message"] mutableCopy];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
            NSArray *listArray = obj[@"list"];
            if (listArray.count >= 4) {
                [self.dataArray addObject:[LDGGiftEmoticonModel mj_objectArrayWithKeyValuesArray:listArray]];
            }
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           complete(error);
        });
    }else{
        error = [NSError errorWithDomain:@"服务器错误" code:404 userInfo:nil];
        complete(error);
    }
}
@end
