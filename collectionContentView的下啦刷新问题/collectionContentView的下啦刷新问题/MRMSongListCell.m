//
//  MRMSongListCell.m
//  MaxRapMusic
//
//  Created by guoqiang on 2017/4/11.
//  Copyright © 2017年 richInfo. All rights reserved.
//




#import "MRMSongListCell.h"

@interface MRMSongListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *songImageView;
@property (weak, nonatomic) IBOutlet UILabel*songLabel;




@end

@implementation MRMSongListCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
}
-(void)setNameStr:(NSString *)nameStr{
   
    self.songImageView.image = [UIImage imageNamed:@"1"];
    self.songLabel.text = @"asdasdasdasd";
}
@end
