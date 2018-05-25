//
//  LDGMessageView.h
//  ZhiBo
//
//  Created by 刘殿阁 on 2018/5/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGMessageView : UIView

@property (weak, nonatomic) IBOutlet UITextField *messsageTextField;
@property (strong, nonatomic) void (^sendTextBlock)(NSString *textStr);


@end
