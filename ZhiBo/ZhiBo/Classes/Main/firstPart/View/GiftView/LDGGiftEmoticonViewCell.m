//
//  LDGGiftEmoticonViewCell.m
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGGiftEmoticonViewCell.h"


@interface LDGGiftEmoticonViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *subobjetLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;


@end
@implementation LDGGiftEmoticonViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.layer.borderColor = [[UIColor orangeColor] CGColor];
    backView.layer.borderWidth = 3.0;
    self.selectedBackgroundView = backView;
    
}
-(void)setEmoticonGiftModel:(LDGGiftEmoticonModel *)emoticonGiftModel{
    _emoticonGiftModel = emoticonGiftModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:emoticonGiftModel.img2]];
    self.subobjetLable.text = emoticonGiftModel.subject;
    self.priceLable.text = [NSString stringWithFormat:@"%d",emoticonGiftModel.coin];
}


@end
