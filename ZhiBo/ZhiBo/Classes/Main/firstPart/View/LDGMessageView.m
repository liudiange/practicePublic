//
//  LDGMessageView.m
//  ZhiBo
//
//  Created by 刘殿阁 on 2018/5/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGMessageView.h"

@interface LDGMessageView ()

@property (weak, nonatomic) IBOutlet UIButton *sendButton;


@end

@implementation LDGMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton *emoticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emoticonButton.frame = CGRectMake(0, 0, 50, 50);
    [emoticonButton setImage:[UIImage imageNamed:@"chat_btn_emoji"] forState:UIControlStateNormal];
    [emoticonButton setImage:[UIImage imageNamed:@"chat_btn_keyboard"] forState:UIControlStateSelected];
    self.messsageTextField.rightView = emoticonButton;
    self.messsageTextField.rightViewMode = UITextFieldViewModeAlways;
    
    
}
/**
 点击发送按钮

 @param sender 按钮
 */
- (IBAction)sendButtonAction:(UIButton *)sender {
    
}



@end
