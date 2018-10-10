//
//  DGListHeaderViewModel.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGListHeaderViewModel.h"

@implementation DGListHeaderViewModel


#pragma mark - lazy
-(NSMutableArray *)headerDataArray {
    if (!_headerDataArray) {
        _headerDataArray = [[NSMutableArray alloc] init];
    }
    return _headerDataArray;
}
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
@end
