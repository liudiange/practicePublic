//
//  LDGInterActiveView.h
//  ZhiBo
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGInterActiveTableView.h"
@interface LDGInterActiveView : UIView

@property (weak, nonatomic) IBOutlet LDGInterActiveTableView *tableView;

/**
 进行刷新表格

 @param str str
 */
- (void)interReloadData:(NSString *)str;

@end
