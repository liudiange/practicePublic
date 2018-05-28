//
//  LDGInterActiveTableView.h
//  ZhiBo
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGInterActiveTableView : UITableView

/**
 为了点击table 键盘什么的下去
 */
@property (strong, nonatomic) void (^selectTable)();

@end
