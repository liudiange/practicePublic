//
//  myView.h
//  block的常规使用
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myView : UIView

@property (copy, nonatomic) void (^myBlock)(int x,int y);


@end
