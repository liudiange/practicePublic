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
#import "LDGGiftEmoticonView.h"
#import "LDGHomeModel.h"


#define MESSAGEBAR 50
#define GIFT_VIEW_HEIGHT 330
@interface LDGZhiBoViewController : UIViewController


@property (strong, nonatomic) LDGAuthorModel *authorModel;
@property (nonatomic, strong) LDGMessageView *messageView;
@property (strong, nonatomic) LDGGiftEmoticonView *giftEmoticomView;

@end
