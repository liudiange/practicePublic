//
//  DGHomeViewModel.h
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "DGListHeaderViewModel.h"

@interface DGHomeViewModel : DGBaseViewModel


@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) RACSubject *refreshEndUI;
@property (strong, nonatomic) RACSubject *refreashUI;
@property (strong, nonatomic) RACSubject *getData;
@property (strong, nonatomic) RACCommand *upLoadMore;
@property (strong, nonatomic) RACCommand *downRefresh;
@property (strong, nonatomic) DGListHeaderViewModel *listHeaderViewModel;



@end
