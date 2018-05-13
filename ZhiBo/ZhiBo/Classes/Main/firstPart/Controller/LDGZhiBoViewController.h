//
//  LDGZhiBoViewController.h
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDGAuthorModel.h"
#import "LDGMessageView.h"

@interface LDGZhiBoViewController : UIViewController

@property (strong, nonatomic) LDGAuthorModel *authorModel;
@property (nonatomic, strong) LDGMessageView *messageView;

@end
