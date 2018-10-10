//
//  DGBaseViewControllerProtocol.h
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DGBaseViewControllerProtocol<NSObject>
@optional

- (void)DG_addSubViews;
- (void)DG_bindViewModel;
- (void)DG_Navigations;
- (void)DG_getData;

@end

