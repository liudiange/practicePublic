//
//  DGListHeaderCollectionViewCell.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGListHeaderCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface DGListHeaderCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLable;



@end
@implementation DGListHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(DGListModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.headerImageStr]];
    self.bottomLable.text = model.content;
}


@end
