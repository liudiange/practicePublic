//
//  DGCollectionReusableView.m
//  collectionViewHeader
//
//  Created by 刘殿阁 on 2018/7/21.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "DGCollectionReusableView.h"

@interface DGCollectionReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *titlelable;

@end

@implementation DGCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setTitleArray:(NSMutableArray *)titleArray {
    _titleArray = titleArray;
    self.titlelable.text = (NSString *)[titleArray firstObject];
    
}
@end
