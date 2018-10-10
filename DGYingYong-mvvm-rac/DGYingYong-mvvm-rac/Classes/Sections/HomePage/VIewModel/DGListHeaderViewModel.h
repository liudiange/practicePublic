//
//  DGListHeaderViewModel.h
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DGListHeaderViewModel : DGBaseViewModel

@property (strong, nonatomic) NSMutableArray *headerDataArray;
@property (strong, nonatomic) RACSubject *refreshUI;

@end
