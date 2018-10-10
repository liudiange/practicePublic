//
//  DGBaseViewProtol.h
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGBaseViewModel.h"
#import "DGBaseViewModelProtocol.h"


@protocol DGBaseViewProtol <NSObject>
@optional

- (void)DG_setUpSubViews;
- (void)DG_bindViewModel;
- (void)DG_getData;


- (void)dg_setViewModel:(DGBaseViewModel *)viewModel;
- (instancetype)initWithViewModel:(id <DGBaseViewModelProtocol>)viewModel;



@end
