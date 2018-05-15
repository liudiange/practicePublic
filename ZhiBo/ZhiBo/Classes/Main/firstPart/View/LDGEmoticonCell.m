//
//  LDGEmoticonCell.m
//  ZhiBo
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGEmoticonCell.h"

@interface LDGEmoticonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *emoticonImageView;


@end
@implementation LDGEmoticonCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
- (void)setEmoticomModel:(LDGEmoticonModel *)emoticomModel {
    _emoticomModel = emoticomModel;
    self.emoticonImageView.image = [UIImage imageNamed:emoticomModel.emoticonImageName];
    
}
@end
