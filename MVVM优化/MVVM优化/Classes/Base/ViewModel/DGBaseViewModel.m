//
//  DGBaseViewModel.m
//  MVVM优化
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseViewModel.h"

@implementation DGBaseViewModel

-(NSMutableArray *)serverDataArray {
    if (!_serverDataArray) {
        _serverDataArray = [[NSMutableArray alloc] init];
    }
    return _serverDataArray;
}
-(instancetype)init{
    
    if (self = [super init]) {
        
        [self DG_bindViewModel];
    }
    return self;
}
-(void)DG_bindViewModel{}


@end
