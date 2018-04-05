//
//  LDGSwipeableViewCell.m
//  探探动画
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGSwipeableViewCell.h"

@interface LDGSwipeableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLableConstaton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLableConstaton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLableConstaton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLableConstaton;

@end

@implementation LDGSwipeableViewCell
-(void)setInfo:(AVCardInfo *)info {
    _info = info;
    self.titleLable.text = info.title;
    self.subTitle.text = info.summary;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.leftLableConstaton.constant = 0;
//    self.rightLableConstaton.constant = 0;
//    self.topLableConstaton.constant = 0;
//    self.heightLableConstaton.constant = 21;
    
}

@end
