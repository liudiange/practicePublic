//
//  LDGInteractiveTextCell.m
//  ZhiBo
//
//  Created by apple on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGInteractiveTextCell.h"

@interface LDGInteractiveTextCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLable;


@end

@implementation LDGInteractiveTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.textColor = [UIColor whiteColor];
}
-(void)setTextStr:(NSAttributedString *)textStr {
    _textStr = textStr;
    self.textLabel.attributedText = textStr;
}
@end
