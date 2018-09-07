//
//  DGAnimationView.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGAnimationView.h"

@interface DGAnimationView()

@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;

@end

@implementation DGAnimationView
/**
 动画的类型
 */
- (void)setAnimationType:(DGAnimationType)type{
    
    NSMutableArray *imagesArray = [NSMutableArray array];
    switch (type) {
        case DGAnimationTypeCommon:
        {
            for (NSInteger index = 1; index <= 16; index++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cxco_loading_%zd",index]];
                [imagesArray addObject:image];
            }
        }
            break;
        case DGAnimationType1:
        {
            for (NSInteger index = 1; index <= 16; index++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cxco_loading_white_%zd",index]];
                [imagesArray addObject:image];
            }
        }
            break;
        case DGAnimationType2:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    self.animationImageView.animationImages = imagesArray;
    self.animationImageView.animationDuration = 1;
    self.animationImageView.animationRepeatCount = NSIntegerMax;
    self.animationImageView.image = [imagesArray lastObject];
    [self.animationImageView startAnimating];
}

@end
