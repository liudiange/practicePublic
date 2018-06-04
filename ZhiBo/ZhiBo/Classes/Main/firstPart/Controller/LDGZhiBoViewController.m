//
//  LDGZhiBoViewController.m
//  ZhiBo
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGZhiBoViewController.h"
#import "LDGAuthorView.h"
#import "LDGZhiBoBottomView.h"
#import "LDGGiftEmoticonManager.h"
#import "LDGHomeServer.h"
#import "LDGInterActiveView.h"
#import "LDGMessageTransformTool.h"
#import "LDGDisplayView.h"
#import "LDGDetailMessageTool.h"


@interface LDGZhiBoViewController ()<LDGMessageTransformToolDelegate>
@property (weak, nonatomic) IBOutlet UIButton *followPeopleButton;
@property (weak, nonatomic) IBOutlet LDGAuthorView *authorView;
@property (weak, nonatomic) IBOutlet LDGZhiBoBottomView *bottomView;
@property (strong, nonatomic) LDGMessageTransformTool *messageTool;
@property (strong, nonatomic) LDGInterActiveView *interActiveView;
@property (strong, nonatomic) LDGDisplayView *displayView;

@end
@implementation LDGZhiBoViewController

-(LDGMessageTransformTool *)messageTool {
    if (!_messageTool) {
        _messageTool = [[LDGMessageTransformTool alloc] initWithConnectServer];
    }
    return _messageTool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    [self addNotification];
    [self setUpSocket];
    [self sendMessage];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
/**
 初始化的相关的操作
 */
- (void)setUp{
    
    self.navigationController.navigationBar.hidden = YES;
    self.authorView.authorModel = self.authorModel;
    self.bottomView.zhiboVc = self;
    // 添加message的在底部键盘
    LDGMessageView *messageView = [LDGMessageView loadViewXib];
    messageView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, MESSAGEBAR);
    [self.view addSubview:messageView];
    self.messageView = messageView;
    // 添加直播的tableview
    LDGInterActiveView *interActiveView = [LDGInterActiveView loadViewXib];
    interActiveView.frame = CGRectMake(0, 64, self.view.frame.size.width, 300);
    [self.view addSubview:interActiveView];
    self.interActiveView = interActiveView;
    self.interActiveView.userInteractionEnabled = YES;
    // 添加礼物的键盘
    self.giftEmoticomView = [LDGGiftEmoticonView loadViewXib];
    self.giftEmoticomView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, GIFT_VIEW_HEIGHT);
    [self.view addSubview:self.giftEmoticomView];
    // 创建送礼物动画的view
    LDGDisplayView *displayView = [[LDGDisplayView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 110) withChannnelCount:2];
    displayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:displayView];
    self.displayView = displayView;
}
/**
 监听键盘的点击
 */
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 初始化socket
 */
- (void)setUpSocket{
    self.messageTool.toolDelegate = self;
}
#pragma mark - 其他事件的处理
/**
 键盘的事件的处理

 @param info 通知信息
 */
- (void)keyBoardChangeAction:(NSNotification *)info{

    CGRect keyboardRect = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = ScreenHeight - keyboardRect.origin.y;
    if (keyboardH > 0) { // 键盘谈起来
        self.messageView.xmg_top = keyboardRect.origin.y - MESSAGEBAR;
    }else { // 键盘落下去
        self.messageView.xmg_top = ScreenHeight;
    }
    [UIView animateWithDuration:0.25 animations:^{
        // 防止在后面来回跳动
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [self.view layoutIfNeeded];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.giftEmoticomView.xmg_top = ScreenHeight;
    }];
}
#pragma mark - 发送消息相关的
/**
 发送文本消息 礼物消息 进入 进去等等的消息
 */
- (void)sendMessage {
    @weakify(self);
    // 文本消息
    self.messageView.sendTextBlock = ^(NSString *textStr) {
        @strongify(self);
        [self.messageTool sendTextMessage:textStr];
    };
    // 礼物消息
    self.giftEmoticomView.sendGift = ^(LDGGiftEmoticonModel *model) {
        @strongify(self);
        [self.messageTool sendGiftMessage:model.img2 giftName:model.subject giftCount:[NSString stringWithFormat:@"%d",model.coin]];
    };
    // 点击了tableview
    self.interActiveView.tableView.selectTable = ^{
        @strongify(self);
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.25 animations:^{
            self.giftEmoticomView.xmg_top = ScreenHeight;
        }];
    };  
}
#pragma mark - 一些常规的按钮的点击事件
/**
 返回的点击事件

 @param sender 按钮
 */
- (IBAction)backAction:(UIButton *)sender {
    [self.displayView removeFromSuperview];
    self.displayView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 关注的人的点击事件

 @param sender 按钮
 */
- (IBAction)followPeopleAction:(UIButton *)sender {
    
    LDGLog(@"点击了关注的人按钮");
}
#pragma mark - socket 接受到消息的delegate
/**
 已经接收到进入到 房间消息了
 
 @param userI userI
 */
- (void)haveJoinRoom:(UserInfo *)userI{
    // [self.interActiveView interReloadData:@"我已经进入房间了"];
}

/**
 已经接收到推出到 房间消息了
 
 @param userI userI
 */
- (void)haveLeaveRoom:(UserInfo *)userI{
    //[self.interActiveView interReloadData:@"我已经离开房间了"];
}
/**
 已经接收到收到礼物的消息了
 
 @param giftM giftM
 */
- (void)haveAcceptGiftMessage:(GiftMessage *)giftM{
    
    NSAttributedString *giftStr = [LDGDetailMessageTool handleGiftMessage:giftM];
    [self.interActiveView interReloadData:giftStr];
    // 开始礼物动画
    LDGGiftModel *giftModel = [[LDGGiftModel alloc] init];
    giftModel.senderName = giftM.user.name;
    giftModel.senderIconUrl = @"https://file.qf.56.com/f/upload/photo/giftNew/app/201711011114591509506099523.png";
    giftModel.giftName = giftM.giftname;
    giftModel.giftUrl = giftM.giftURL;
    [self.displayView showGift:giftModel];
    
    
}

/**
 已经接受到文本消息了。大师兄
 
 @param textM 文本消息的model
 */
- (void)haveAcceptTextMessage:(TextMessage *)textM{
    
    NSAttributedString *textStr = [LDGDetailMessageTool handleTextMessage:textM];
    [self.interActiveView interReloadData:textStr];
    
}

@end
