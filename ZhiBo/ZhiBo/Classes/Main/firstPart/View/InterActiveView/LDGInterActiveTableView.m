//
//  LDGInterActiveTableView.m
//  ZhiBo
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGInterActiveTableView.h"

@implementation LDGInterActiveTableView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.selectTable) {
        self.selectTable();
    }
}

@end
