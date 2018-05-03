//
//  LDGHomeBaseController.h
//  ZhiBo
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGHomeModel.h"

@interface LDGHomeBaseController : UIViewController
/**
 这种方式创建控制器

 @param model model
 @return 返回对象本身
 */
- (instancetype)initWithModel:(LDGHomeModel *)model;

@end
