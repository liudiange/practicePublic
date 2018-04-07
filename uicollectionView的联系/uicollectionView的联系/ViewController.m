//
//  ViewController.m
//  uicollectionView的联系
//
//  Created by 刘殿阁 on 2018/4/7.
//  Copyright © 2018年 刘殿阁. All rights reserved.
//

#import "ViewController.h"
#import "LDGItemCell.h"
#import "LDGlineFlowLayout.h"
#import "LDGStaticLayout.h"
#import "LDGCircleLayout.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation ViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

static NSString * const ID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:[[LDGStaticLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"LDGItemCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    // 创建数据
    for (NSInteger index = 1; index <= 20; index ++) {
        NSString *str = [NSString stringWithFormat:@"%zd",index];
        [self.dataArray addObject:str];
    }
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView = collectionView;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDGItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    itemCell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.item]];
    return itemCell;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LDGlineFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];
    }else if([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[LDGStaticLayout alloc] init] animated:YES];
    }else if ([self.collectionView.collectionViewLayout isKindOfClass:[LDGStaticLayout class]]){
         [self.collectionView setCollectionViewLayout:[[LDGCircleLayout alloc] init] animated:YES];
    }else if ([self.collectionView.collectionViewLayout isKindOfClass:[LDGCircleLayout class]]){
        [self.collectionView setCollectionViewLayout:[[LDGlineFlowLayout alloc] init] animated:YES];
    }
}



@end
