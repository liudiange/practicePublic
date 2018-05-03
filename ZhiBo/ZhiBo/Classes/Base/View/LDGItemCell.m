//
//  LDGItemCell.m
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "LDGItemCell.h"
#import "UIImageView+WebCache.h"

@interface LDGItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;


@end
@implementation LDGItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setAuthorModel:(LDGAuthorModel *)authorModel{
    _authorModel = authorModel;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:authorModel.pic51] placeholderImage:[UIImage imageNamed:@"home_icon_people"]];
    self.liveImageView.hidden = authorModel.live >= 1 ? NO : YES;
    self.priceLable.text = authorModel.name;
}

@end
