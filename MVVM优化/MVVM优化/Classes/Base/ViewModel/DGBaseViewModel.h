//
//  DGBaseViewModel.h
//  MVVM优化
//
//  Created by apple on 2018/9/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGBaseViewModel : NSObject


@property (strong, nonatomic) NSMutableArray *serverDataArray;
- (void)DG_bindViewModel;

@end
