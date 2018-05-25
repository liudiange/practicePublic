//
//  LDGGiftEmoticonView.m
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGGiftEmoticonView.h"
#import "LDGCommonModel.h"
#import "LDGContentFlowLayout.h"
#import "LDGContentCollectionView.h"
#import "LDGGiftEmoticonManager.h"
#import "LDGGiftEmoticonViewCell.h"


@interface LDGGiftEmoticonView ()<LDGContentCollectionViewDelegate,LDGContentCollectionViewDatasource>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *presentLable;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet LDGContentCollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (strong, nonatomic) LDGGiftEmoticonManager *giftManager;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation LDGGiftEmoticonView
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
static NSString *emoticon_ID = @"emoticonID";
-(void)awakeFromNib {
    [super awakeFromNib];
    [self obtainData];
}
/**
 从plist文件中拿到数据
 */
- (void)obtainData{
    
    LDGGiftEmoticonManager *giftManager = [[LDGGiftEmoticonManager alloc] init];
    @weakify(giftManager);
    @weakify(self);
    [giftManager startRequest:^(NSError * _Null_unspecified error) {
        @strongify(giftManager);
       @strongify(self);
        if (!error) {
            self.dataArray = giftManager.dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUp];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self.contentCollectionView ldgContentReloadData];
                });
            });
        }else{
            LDGLog(@"网络加载错误");
        }
    }];
    self.giftManager = giftManager;
}
/**
 初始化
 */
- (void)setUp{
    self.sendButton.layer.cornerRadius = 5;
    self.sendButton.layer.masksToBounds = YES;
    
    NSArray *titlesArray = @[@"热门",@"高级",@"豪华",@"专属"];
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.averageCount = 2;
    commonModel.collectionViewBackColor = [UIColor blackColor];
    commonModel.averageCount = 4;
    commonModel.pageControllCommonColor = [UIColor grayColor];
    commonModel.titleViewColor = [UIColor blackColor];
    commonModel.titleTextColor = [UIColor whiteColor];
    
    LDGContentFlowLayout *contentLayout = [[LDGContentFlowLayout alloc] init];
    contentLayout.minimumLineSpacing = 0;
    contentLayout.minimumInteritemSpacing = 0;
    contentLayout.layoutCows = 2;
    contentLayout.layoutColumns = 4;
    
    self.contentCollectionView.titles = [titlesArray copy];
    self.contentCollectionView.collectionLayout = contentLayout;
    self.contentCollectionView.commonModel = commonModel;
    self.contentCollectionView.titleViewHeight = 44;
    self.contentCollectionView.isShouldBottom = NO;
    [self.contentCollectionView startSetUp];
    
    self.contentCollectionView.contnetViewDelegate = self;
    self.contentCollectionView.contentViewDataSource = self;
    [self.contentCollectionView ldgContentRegisterNib:[UINib nibWithNibName:@"LDGGiftEmoticonViewCell" bundle:nil] forCellWithReuseIdentifier:emoticon_ID];
    [self addSubview:self.contentCollectionView];
    [self.contentCollectionView ldgContentReloadData];
}
#pragma mark - 按钮的点击事件
/**
 充值的事件

 @param sender 按钮
 */
- (IBAction)rechargeButtonAction:(UIButton *)sender {
    
    
}
/**
 发送的事件

 @param sender 发送
 */
- (IBAction)sendButtonAction:(UIButton *)sender {
    
    
}
#pragma mark - collectionView - datasource
- (NSInteger)numberOfSectionsInldgContentCollectionView:(UICollectionView *)collectionView{
    
    return self.giftManager.dataArray.count;
}
- (NSInteger)ldgContentCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count) {
        NSArray *array = self.dataArray[section];
        return array.count;
    }else{
        return 0;
    }
}
- (__kindof UICollectionViewCell *)ldgContentCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LDGGiftEmoticonViewCell *emoticonCell = [collectionView dequeueReusableCellWithReuseIdentifier:emoticon_ID forIndexPath:indexPath];
    emoticonCell.emoticonGiftModel = self.dataArray[indexPath.section][indexPath.item];
    return emoticonCell;
}
#pragma mark collectionView - delegate
- (void)ldgContentCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LDGGiftEmoticonModel *model = self.dataArray[indexPath.section][indexPath.item];
    if (self.sendGift) {
        self.sendGift(model);
    }
}

@end
