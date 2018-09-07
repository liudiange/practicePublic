//
//  DGDefaultView.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGDefaultView.h"


@interface DGDefaultView ()

@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end
@implementation DGDefaultView

/**
 设置属性
 
 @param type 设置相关的type
 */
- (void)DG_setEmptyViewType:(DGEmptyViewType)type{
    switch (type) {
        case DGEmptyViewTypeNoNetWork:
        {
            self.resetButton.hidden = YES;
            self.tipLable.text = @"对不起兄弟没有网络了";
        }
            break;
        case DGEmptyViewTypeNoData:
        {
            self.tipLable.text = @"对不起兄弟没有数据";
            self.resetButton.hidden = NO;
        }
            break;
        case DGEmptyViewTypeCustom:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
/**
 点击加载重试

 @param sender 点击的事件
 */
- (IBAction)resetButtonAction:(UIButton *)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock();
    }
}
@end
