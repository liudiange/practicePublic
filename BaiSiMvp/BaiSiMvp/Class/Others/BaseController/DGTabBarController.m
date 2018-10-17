//
//  DGTabBarController.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGTabBarController.h"
#import "DGNavigationController.h"
#import "DGEssenceController.h"
#import "DGNewPostViewController.h"
#import "DGMeViewController.h"
#import "DGFellowViewController.h"

@interface DGTabBarController ()

@end

@implementation DGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改选中字体属性
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObject:[self class]]];
    
    NSMutableDictionary *attrsDic = [NSMutableDictionary dictionary];
    attrsDic[NSForegroundColorAttributeName] = [UIColor greenColor];
    attrsDic[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];
    
    NSMutableDictionary *selectAttrsDic = [NSMutableDictionary dictionary];
    selectAttrsDic[NSForegroundColorAttributeName] = [UIColor redColor];
    selectAttrsDic[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];
    
    [tabBarItem setTitleTextAttributes:attrsDic forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectAttrsDic forState:UIControlStateSelected];
    
    // 添加儿子控制器
    [self addChildVc];
    
}
#pragma mark - 一些常规的操作

/**
 添加控制器
 */
- (void)addChildVc{
    
    [self addChildVc:[[DGEssenceController alloc] init] title:@"精华" imageName:@"bottom_messages_unselect" selectImageName:@"bottom_messages_select"];
    [self addChildVc:[[DGNewPostViewController alloc] init] title:@"新帖" imageName:@"bottom_contact_unselect" selectImageName:@"bottom_contact_select"];
    [self addChildVc:[[DGFellowViewController alloc] init] title:@"关注" imageName:@"bottom_wallet_unselect" selectImageName:@"bottom_wallet_select"];
    [self addChildVc:[[DGMeViewController alloc] init] title:@"我" imageName:@"bottom_setting_unselect" selectImageName:@"bottom_setting_select"];
    
}
/**
 公共方法添加子控制器

 @param viewVc 控制器的vc
 @param title 标题
 @param imageName 名字
 @param selectImageName 选中图片的名字
 */
- (void)addChildVc:(UIViewController *)viewVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    
    DGNavigationController *navi = [[DGNavigationController alloc] initWithRootViewController:viewVc];
    navi.tabBarItem.title = title;
    navi.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectImage = [UIImage imageNamed:selectImageName];
    navi.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:navi];
}
@end
