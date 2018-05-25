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



@interface LDGZhiBoViewController ()<LDGMessageTransformToolDelegate>
@property (weak, nonatomic) IBOutlet UIButton *followPeopleButton;
@property (weak, nonatomic) IBOutlet LDGAuthorView *authorView;
@property (weak, nonatomic) IBOutlet LDGZhiBoBottomView *bottomView;
@property (strong, nonatomic) LDGMessageTransformTool *messageTool;
@property (strong, nonatomic) LDGInterActiveView *interActiveView;

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
    //初始化以及其他的相关的操作
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
    // 点击了cell
    self.interActiveView.selectTable = ^{
        @strongify(self);
    };
    
}
#pragma mark - 一些常规的按钮的点击事件
/**
 返回的点击事件

 @param sender 按钮
 */
- (IBAction)backAction:(UIButton *)sender {
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
    [self.interActiveView interReloadData:@"我已经进入房间了"];
}

/**
 已经接收到推出到 房间消息了
 
 @param userI userI
 */
- (void)haveLeaveRoom:(UserInfo *)userI{

    [self.interActiveView interReloadData:@"我已经离开房间了"];
}
/**
 已经接收到收到礼物的消息了
 
 @param giftM giftM
 */
- (void)haveAcceptGiftMessage:(GiftMessage *)giftM{
    NSString *textStr = [NSString stringWithFormat:@"%@ - %@ -%@",giftM.giftname,giftM.giftURL,giftM.giftCount];
    [self.interActiveView interReloadData:textStr];
}

/**
 已经接受到文本消息了。大师兄
 
 @param textM 文本消息的model
 */
- (void)haveAcceptTextMessage:(TextMessage *)textM{
    [self.interActiveView interReloadData:textM.text];
    
}

@end
