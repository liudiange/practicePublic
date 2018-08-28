//
//  DGShareInfo.m
//  同时来多个数据的时候处理tableview
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGShareInfo.h"

@implementation DGShareInfo

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
-(NSLock *)dataLock {
    if (!_dataLock) {
        _dataLock = [[NSLock alloc] init];
    }
    return _dataLock;
}
/**
 单利对象
 
 @return 返回对象本身
 */
+(instancetype)shareInfo{
    
    
    static id shareInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInfo = [[self alloc] init];
    });
    return shareInfo;
    
}


@end
