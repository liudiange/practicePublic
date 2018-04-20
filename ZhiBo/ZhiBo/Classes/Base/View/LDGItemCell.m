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


@end
@implementation LDGItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setShopModel:(LDGShopModel *)shopModel{
    _shopModel = shopModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shopModel.img]];
    self.priceLable.text = shopModel.price;
    
}

@end
