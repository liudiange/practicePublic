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

@interface LDGGiftEmoticonView ()<LDGContentCollectionViewDelegate,LDGContentCollectionViewDatasource>

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *presentLable;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet LDGContentCollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;

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
   // [self setUp];
}
/**
 从plist文件中拿到数据
 */
- (void)obtainData{
    LDGGiftEmoticonManager *giftManager = [[LDGGiftEmoticonManager alloc] init];
     @weakify(giftManager)
    [giftManager startRequest:^(NSError * _Null_unspecified error) {
        __weak typeof(giftManager)weakHomeServer = giftManager;
        giftManager.dataArray;
        if (!error) {
            
        }else{
            
        }
    }];
}
/**
 初始化
 */
- (void)setUp{
    
    self.sendButton.layer.cornerRadius = 5;
    self.sendButton.layer.masksToBounds = YES;
    
    NSArray *titlesArray = @[@"普通",@"粉丝专属"];
    LDGCommonModel *commonModel = [[LDGCommonModel alloc] init];
    commonModel.averageCount = 2;
    commonModel.pageControllCommonColor = [UIColor grayColor];
    LDGContentFlowLayout *contentLayout = [[LDGContentFlowLayout alloc] init];
    contentLayout.minimumLineSpacing = 10;
    contentLayout.minimumInteritemSpacing = 10;
    contentLayout.layoutCows = 3;
    contentLayout.layoutColumns = 7;
    LDGContentCollectionView *contentCollection = [[LDGContentCollectionView alloc] initWithFrame:self.bounds titleH:44 isShouldBottom:YES titles:titlesArray layout:contentLayout withCommonModel:commonModel];
    contentCollection.contnetViewDelegate = self;
    contentCollection.contentViewDataSource = self;
    [contentCollection ldgContentRegisterNib:[UINib nibWithNibName:@"LDGEmoticonCell" bundle:nil] forCellWithReuseIdentifier:emoticon_ID];
    [self addSubview:contentCollection];
    [contentCollection ldgContentReloadData];
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
    
    return self.dataArray.count;
}
- (NSInteger)ldgContentCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (__kindof UICollectionViewCell *)ldgContentCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return nil;
}
#pragma mark collectionView - delegate
- (void)ldgContentCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
}

@end
