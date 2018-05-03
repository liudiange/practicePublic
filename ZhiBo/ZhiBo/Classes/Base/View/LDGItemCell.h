//
//  LDGItemCell.h
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGAuthorModel.h"

@interface LDGItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) LDGAuthorModel *authorModel;


@end
