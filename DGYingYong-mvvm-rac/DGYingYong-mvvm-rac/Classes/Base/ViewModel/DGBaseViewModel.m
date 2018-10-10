//
//  DGBaseViewModel.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseViewModel.h"

@implementation DGBaseViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self DG_bindViewModel];
        [self DG_getData];
    }
    return self;
}
- (void)DG_bindViewModel{}
- (void)DG_getData{}


@end
