//
//  DGBaseViewController.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface DGBaseViewController ()

@end

@implementation DGBaseViewController

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    DGBaseViewController *viewVc = [super allocWithZone:zone];
        @weakify(viewVc);
    [[viewVc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id  _Nullable x) {
        @strongify(viewVc);
        
        [viewVc DG_bindViewModel];
        [viewVc DG_addSubViews];
        [viewVc DG_getData];
    }];
    
    [[viewVc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id  _Nullable x) {
        @strongify(viewVc);
        [viewVc DG_Navigations];
    }];
    return viewVc;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (void)DG_getData{}
- (void)DG_addSubViews{}
- (void)DG_bindViewModel{}
- (void)DG_Navigations{}

@end
