//
//  LDGMessageView.m
//  ZhiBo
//
//  Created by 刘殿阁 on 2018/5/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGMessageView.h"
#import "LDGEmoticonView.h"

@interface LDGMessageView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) LDGEmoticonView *emoticomView;

@end

@implementation LDGMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sendButton.layer.cornerRadius = 5;
    self.sendButton.layer.masksToBounds = YES;
    // 右边的表情button
    UIButton *emoticonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emoticonButton.frame = CGRectMake(0, 0, 50, 50);
    [emoticonButton setImage:[UIImage imageNamed:@"chat_btn_emoji"] forState:UIControlStateNormal];
    [emoticonButton setImage:[UIImage imageNamed:@"chat_btn_keyboard"] forState:UIControlStateSelected];
    [emoticonButton addTarget:self action:@selector(emoticonChange:) forControlEvents:UIControlEventTouchUpInside];
    self.messsageTextField.rightView = emoticonButton;
    self.messsageTextField.rightViewMode = UITextFieldViewModeAlways;
    self.messsageTextField.returnKeyType = UIReturnKeySend;

    // 表情键盘
    self.emoticomView = [[LDGEmoticonView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    // 表情点击
    @weakify(self);
    self.emoticomView.CollectionSelected = ^(LDGEmoticonModel *emoticonModel) {
        @strongify(self);
        if ([emoticonModel.emoticonImageName isEqualToString:@"delete-n"]) {
            [self.messsageTextField deleteBackward];
        }else{
            UITextRange *range = self.messsageTextField.selectedTextRange;
            [self.messsageTextField replaceRange:range withText:emoticonModel.emoticonImageName];
        }
    };
}
/**
 点击表情键盘切换的按钮
 */
- (void)emoticonChange:(UIButton *)button{
    button.selected = !button.isSelected;
    UITextRange *range = self.messsageTextField.selectedTextRange;
    if (button.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            self.messsageTextField.inputView = self.emoticomView;
            [self.messsageTextField becomeFirstResponder];
        }];
    }else{
        self.messsageTextField.inputView = nil;
        [self.messsageTextField becomeFirstResponder];
    }
    self.messsageTextField.selectedTextRange = range;
}
/**
 点击发送按钮

 @param sender 按钮
 */
- (IBAction)sendButtonAction:(UIButton *)sender {
    if (self.sendTextBlock) {
        self.sendTextBlock(self.messsageTextField.text);
    }
    self.messsageTextField.text = nil;
}
#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendButtonAction:self.sendButton];
    return YES;
}
@end
