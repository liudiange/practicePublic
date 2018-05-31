//
//  ViewController.m
//  礼物的动画
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LDGAnimationLable.h"
#import "LDGDisplayView.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet LDGAnimationLable *animationLable;
@property (strong, nonatomic) LDGDisplayView *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建LDGDisplayView
    LDGDisplayView *displayView = [[LDGDisplayView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 110) withChannnelCount:2];
    displayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:displayView];
    self.displayView = displayView;

}
/**
 按钮1的点击事件

 @param sender sender
 */
- (IBAction)button1Action:(UIButton *)sender {
 
    LDGGiftModel *giftModel = [[LDGGiftModel alloc] init];
    giftModel.senderName = @"刘殿阁";
    giftModel.senderIconUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011114591509506099523.png";
    giftModel.giftName = @"火箭";
    giftModel.giftUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011054341509504874931.png";
    [self.displayView showGift:giftModel];
    
}
/**
 按钮2的点击事件

 @param sender sender
 */
- (IBAction)button2Action:(UIButton *)sender {
    LDGGiftModel *giftModel = [[LDGGiftModel alloc] init];
    giftModel.senderName = @"小伙子";
    giftModel.senderIconUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011114591509506099523.png";
    giftModel.giftName = @"汽车";
    giftModel.giftUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011114591509506099523.png";
    [self.displayView showGift:giftModel];
 
    
}
/**
 按钮三的点击事件

 @param sender sender
 */
- (IBAction)button3Action:(UIButton *)sender {
    LDGGiftModel *giftModel = [[LDGGiftModel alloc] init];
    giftModel.senderName = @"很帅";
    giftModel.senderIconUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011114591509506099523.png";
    giftModel.giftName = @"轮船";
    giftModel.giftUrl = @"https://file.qf.56.com/f/upload/photo/gift/m/v2/thumb/haitunzhilian_1.png";
    [self.displayView showGift:giftModel];
    
}





@end
