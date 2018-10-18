//
//  DGEssenceController.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssenceController.h"
#import "DGEssenceAllTableViewController.h"
#import "DGEssenceWordTableViewController.h"
#import "DGEssenceAudioTableViewController.h"
#import "DGEssenceVideoTableViewController.h"
#import "DGEssencePictureTableViewController.h"
#import "DGEssenceProtocol.h"
#import "DGEssencePresenter.h"

@interface DGEssenceController ()<DGEssenceProtocol>

@property (strong, nonatomic) DGEssencePresenter *presenter;
@end

@implementation DGEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化相关事宜
    self.presenter = [[DGEssencePresenter alloc] init];
    [self.presenter attchView:self];
    // 设置子控制相关
    [self.presenter addChildVc:[self getControllerVcArray] titles:[self getControllerTitleArray]];
}
#pragma mark - ControlelrVc Protocol

/**
 获取子控制器

 @return 返回子控制器的数组
 */
- (NSArray<UIViewController *> *)getControllerVcArray{
    
    DGEssenceAllTableViewController *allVC = [[DGEssenceAllTableViewController alloc] init];
    DGEssenceVideoTableViewController *videoVc = [[DGEssenceVideoTableViewController alloc] init];
    DGEssenceAudioTableViewController *audioVc = [[DGEssenceAudioTableViewController alloc] init];
    DGEssencePictureTableViewController *pictureVc = [[DGEssencePictureTableViewController alloc] init];
    DGEssenceWordTableViewController *wordVc = [[DGEssenceWordTableViewController alloc] init];
    
    [self addChildViewController:allVC];
    [self addChildViewController:videoVc];
    [self addChildViewController:audioVc];
    [self addChildViewController:pictureVc];
    [self addChildViewController:wordVc];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    [vcArray addObject:allVC];
    [vcArray addObject:videoVc];
    [vcArray addObject:audioVc];
    [vcArray addObject:pictureVc];
    [vcArray addObject:wordVc];
    return vcArray;
    
}
/**
 获取子控制器标题的数组

 @return 标题的数组
 */
-(NSArray<NSString *> *)getControllerTitleArray{
    
    NSMutableArray *titleArray = [NSMutableArray array];
    [titleArray addObject:@"全部"];
    [titleArray addObject:@"视频"];
    [titleArray addObject:@"音频"];
    [titleArray addObject:@"图片"];
    [titleArray addObject:@"文字"];
    return titleArray;
    
}





@end
