//
//  ViewController.m
//  collectionContentView的下啦刷新问题
//
//  Created by apple on 2018/7/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MRMSongListCell.h"
#import "MRMHeaderCollectionCell.h"
#import "JHHeaderFlowLayout.h"
#import "MRMCollectionViewModel.h"
#import "MRMHttpViewModel.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) MRMCollectionViewModel *collectionViewModel;
@property (strong, nonatomic) MRMHttpViewModel *httpViewModel;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionViewModel = [[MRMCollectionViewModel alloc] initWithCollectionView:self.collectionView];
    self.httpViewModel = [[MRMHttpViewModel alloc] init];
    [self.collectionView reloadData];

}
@end
