//
//  myView.m
//  block的常规使用
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "myView.h"

@implementation myView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.myBlock) {
        self.myBlock(10, 10);
    }
}

@end
