//
//  LDGAnimationLable.h
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGAnimationLable : UILabel
/**
 开始动画
 
 @param complete complete
 */
-(void)startAnimation:(void (^)(BOOL isFinish))complete;

@end
