//
//  LDGAuthorView.m
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGAuthorView.h"

@interface LDGAuthorView ()

@property (weak ,nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak ,nonatomic) IBOutlet UILabel *homeLable;
@property (weak ,nonatomic) IBOutlet UIButton *followButton;


@end

@implementation LDGAuthorView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.followButton.layer.cornerRadius = 5;
    self.followButton.layer.masksToBounds = YES;
}
-(void)setAuthorModel:(LDGAuthorModel *)authorModel {
    _authorModel = authorModel;
    self.nickNameLable.text = authorModel.name;
    self.homeLable.text = [NSString stringWithFormat:@"房间号: %d",authorModel.roomid];
}

#pragma mark - 按钮的点击事件
/**
 按钮的点击事件

 @param sender 按钮
 */
- (IBAction)followButtonAction:(UIButton *)sender {
    
    
    
}
@end
