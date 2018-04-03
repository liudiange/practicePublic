//
//  DefaultViewController.m
//  LZSwipeableViewDemo
//
//  Created by 周济 on 16/4/21.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "DefaultViewController.h"
#import "LZSwipeableView.h"
#import "AVCardInfo.h"
#import "AVSwipeCardCell.h"
#import "AVKnackBottomToolView.h"
@interface DefaultViewController ()<LZSwipeableViewDataSource,
LZSwipeableViewDelegate,AVKnackBottomToolViewDelegate>
@property (nonatomic, strong) NSMutableArray *cardInfoList;
@property (nonatomic, strong) LZSwipeableView *swipeableView;
// cell
@property (nonatomic, strong) LZSwipeableViewCell *topCell;
@end

@implementation DefaultViewController

- (NSMutableArray *)cardInfoList{
    if (!_cardInfoList) {
        _cardInfoList = [NSMutableArray array];
    }
    return _cardInfoList;
}

- (LZSwipeableView *)swipeableView{
    if (!_swipeableView) {
        _swipeableView = [[LZSwipeableView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
        _swipeableView.datasource = self;
        _swipeableView.delegate = self;
        _swipeableView.backgroundColor = [UIColor colorWithHex:0xebebeb];
        _swipeableView.topCardInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _swipeableView.hidden = YES;
    }
    return _swipeableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.swipeableView];
    self.swipeableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.swipeableView registerClass:[AVSwipeCardCell class] forCellReuseIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    
    self.swipeableView.bottomCardInsetHorizontalMargin = 5;
    self.swipeableView.bottomCardInsetVerticalMargin = 10;
    self.swipeableView.beginIndex = 2;
    
    // 使用xib时请使用以下方法
//    [self.swipeableView registerNibName:NSStringFromClass([AVSwipeCardCell class]) forCellReuseIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    
    for (int i = 0; i < 5; i++) {
        AVCardInfo *info = [[AVCardInfo alloc] init];
        info.feed_id = 123145;
        info.title = [NSString stringWithFormat:@"测试% ----  zd",i];
        info.summary = [NSString stringWithFormat:@"测试---desc---%zd",i];
        info.fav_count = arc4random_uniform(100);
        info.is_fav = arc4random_uniform(1);
        [self.cardInfoList addObject:info];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.swipeableView.hidden = NO;
        [self.swipeableView reloadData];
    });

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.swipeableView.frame = CGRectMake(10, 100, 355, 355);
}

#pragma mark LZSwipeableViewDataSource
- (NSInteger)swipeableViewNumberOfRowsInSection:(LZSwipeableView *)swipeableView{
    return self.cardInfoList.count;
}

- (LZSwipeableViewCell *)swipeableView:(LZSwipeableView *)swipeableView cellForIndex:(NSInteger)index{
    AVSwipeCardCell *cell = [swipeableView dequeueReusableCellWithIdentifier:NSStringFromClass([AVSwipeCardCell class])];
    cell.cardInfo = self.cardInfoList[index];
    cell.backgroundColor = [UIColor orangeColor];
    NSLog(@"cellForIndex -- %@",cell.cardInfo.title);
    return cell;
}

- (LZSwipeableViewCell *)swipeableView:(LZSwipeableView *)swipeableView substituteCellForIndex:(NSInteger)index{
    AVSwipeCardCell *cell = [[AVSwipeCardCell alloc] initWithReuseIdentifier:@""];
    cell.cardInfo = self.cardInfoList[index];
    NSLog(@"substituteCellForIndex -- %@",cell.cardInfo.title);
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark LZSwipeableViewDelegate
- (NSInteger)swipeableViewMaxCardNumberWillShow:(LZSwipeableView *)swipeableView{
    return 4;
}
- (void)swipeableView:(LZSwipeableView *)swipeableView didTapCellAtIndex:(NSInteger)index{
    
//    NSLog(@"点击了哪一个 -- %zd",index);
}
#pragma mark - 头部和脚的处理事件
- (UIView *)footerViewForSwipeableView:(LZSwipeableView *)swipeableView{
    if(self.type == 2){
        return [self showHeaderOrFooterView];
    }
    return nil;
}

- (UIView *)showHeaderOrFooterView{
    AVKnackBottomToolView *bottomView = [AVKnackBottomToolView viewFromXib];
    bottomView.superVCtl = self;
    bottomView.delegate  = self;
    return bottomView;
}

- (CGFloat)heightForFooterView:(LZSwipeableView *)swipeableView{
    if(self.type == 2){
        return 75;
    }
    return 0;
}

- (UIView *)headerViewForSwipeableView:(LZSwipeableView *)swipeableView{
    if(self.type == 1){
        return [self showHeaderOrFooterView];
    }
    return nil;
}

- (CGFloat)heightForHeaderView:(LZSwipeableView *)swipeableView{
    if(self.type == 1){
        return 75;
    }
    return 0;
}

// 拉到最后一个
- (void)swipeableViewDidLastCardRemoved:(LZSwipeableView *)swipeableView{
    
//    NSLog(@"已经是最后一个了");
}

/**
 移除了哪一个卡片

 @param swipeableView swipeableView
 @param index index
 @param direction 方向
 */
- (void)swipeableView:(LZSwipeableView *)swipeableView didCardRemovedOrAddtIndex:(NSInteger)index withDirection:(LZSwipeableViewCellSwipeDirection)direction{
//    NSLog(@"移除或者添加 %zd  --  direction --%zd",index,direction);
}
/**
 点击了最上边的一个

 @param swipeableView swipeableView
 @param topCell 方向
 */
- (void)swipeableView:(LZSwipeableView *)swipeableView didTopCardShow:(LZSwipeableViewCell *)topCell{
//    NSLog(@"点击了最上边的一个");
}
/**
 点击了最下边的一个

 @param swipeableView swipeableView
 @param cell 方向
 */
- (void)swipeableView:(LZSwipeableView *)swipeableView didLastCardShow:(LZSwipeableViewCell *)cell{
//    NSLog(@"点击了最下边的一个");
}
#pragma mark - AVKnackBottomToolViewDelegate
- (void)knackBottomToolViewDidCheckDetailBtnClick:(AVCardInfo *)idInfo{
    [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionLeft];
}


- (void)knackBottomToolViewDidCollectBtnClick:(AVCardInfo *)idInfo{
    [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionRight];
}

- (void)knackBottomToolViewDidShareBtnClick:(AVCardInfo *)idInfo{
    if (self.type == 1) {
      [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionBottom];
    }else{
      [self.swipeableView removeTopCardViewFromSwipe:LZSwipeableViewCellSwipeDirectionTop];
    }
}




@end
