//
//  XMGTabBar.m
//  百思不得姐
//
//  Created by Connect on 2017/7/2.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTabBar.h"
#import "UIView+XMGVIew.h"

@interface XMGTabBar ()

@property(nonatomic, weak) UIButton *plusButton;

@end


@implementation XMGTabBar

- (void)layoutSubviews {
   [super layoutSubviews];
    
    NSInteger index = 0;
    CGFloat buttonW = self.frame.size.width/5.0;
    CGFloat buttonH = self.frame.size.height;
    
    for (UIView *view in self.subviews) {
        if (NSClassFromString(@"UITabBarButton") != view.class) continue;
        CGFloat buttonX = index*buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        view.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
        index ++;
    }
    //创建中间的button
    self.plusButton.xmg_centerX = self.frame.size.width * 0.5;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame] ) {
        
//        self.backgroundImage = [UIImage imageNamed:@"tabbar-item-selected_64x49_"];
    }
    return self;
}
-(UIButton*)plusButton{
    if (_plusButton == nil) {
        UIButton *plButton = [UIButton buttonWithType:UIButtonTypeCustom];
        plButton.frame = CGRectMake(0, 0, self.frame.size.width/5.0, self.frame.size.height);
        [plButton setImage:[UIImage imageNamed:@"contract_add_new_friends_small"] forState:UIControlStateNormal];
        [plButton setImage:[UIImage imageNamed:@"contract_add_new_friends_small"] forState:UIControlStateHighlighted];
        [plButton addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plButton];
        self.plusButton = plButton;
    }
    return _plusButton;
}
- (void)plusButtonClick:(UIButton *)button {
    NSLog(@"asdasd");
}
@end
