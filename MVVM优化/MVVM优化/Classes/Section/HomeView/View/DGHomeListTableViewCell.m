//
//  DGHomeListTableViewCell.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGHomeListTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DGHomeListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
@property (weak, nonatomic) IBOutlet UILabel *secondLable;

@end
@implementation DGHomeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setModel:(DGListModel *)model{
    _model = model;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headerImageStr]];
    self.firstLable.text = model.name;
    self.secondLable.text = model.content;
}


@end
