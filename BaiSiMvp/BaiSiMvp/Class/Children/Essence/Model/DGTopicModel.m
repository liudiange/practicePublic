//
//  DGTopicModel.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGTopicModel.h"

@implementation DGTopicModel
-(CGFloat)cellHeight{
    if (_cellHeight) {return _cellHeight;}
    _cellHeight = 60;
    if (self.text.length > 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
       _cellHeight += [self.text boundingRectWithSize:CGSizeMake(DGScreenWidth - DGMargon*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height + DGMargon;
    }
    switch (self.type) {
        case DGTopicTypePicture:
        {
            
        }
            break;
        case DGTopicTypeWord:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    return 0;
}


@end
