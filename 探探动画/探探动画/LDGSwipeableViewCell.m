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


@end

@implementation LDGSwipeableViewCell
-(void)setInfo:(AVCardInfo *)info {
    _info = info;
    self.titleLable.text = info.title;
    self.subTitle.text = info.summary;
    
}


@end
