//
//  XMGTabBarController.m
//  百思不得姐
//
//  Created by Connect on 2017/6/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGTabBar.h"
#import "XMGNavigationController.h"
#import "XMGFourViewController.h"
#import "XMGOneViewController.h"
#import "XMGTwoViewController.h"
#import "XMGThreeViewController.h"

@interface XMGTabBarController ()


@end

@implementation XMGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *tabBaritem = [UITabBarItem appearance];
    //设置选中的字体与颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = [UIColor greenColor];
   
    [tabBaritem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBaritem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    // 创建子控制器
    [self setUpController];
   
}
/**
 *
 *  创建子控制器
 */
- (void)setUpController {
    
    [self creatChildVc:[[XMGNavigationController alloc]initWithRootViewController:[[XMGOneViewController alloc] init]] withTitle:@"精华" withImageName:@"bottom_messages_unselect" withSelectImageName:@"bottom_messages_select"];

    [self creatChildVc:[[XMGNavigationController alloc]initWithRootViewController:[[XMGTwoViewController alloc]init]] withTitle:@"新帖" withImageName:@"bottom_contact_unselect" withSelectImageName:@"bottom_contact_select"];
    [self creatChildVc:[[XMGNavigationController alloc]initWithRootViewController:[[XMGThreeViewController alloc] init]] withTitle:@"关注" withImageName:@"bottom_wallet_unselect" withSelectImageName:@"bottom_wallet_select"];
    [self creatChildVc:[[XMGNavigationController alloc]initWithRootViewController:[[XMGFourViewController alloc] init]] withTitle:@"我" withImageName:@"bottom_setting_unselect" withSelectImageName:@"bottom_setting_select"];
    //自定义tabar替换
    [self setValue:[[XMGTabBar alloc] init] forKey:@"tabBar"];

}
#pragma mark - action
- (void)creatChildVc:(UIViewController *)controllerVc withTitle:(NSString *)title withImageName:(NSString *)imageName withSelectImageName:(NSString *)selectImageName {
    
    controllerVc.tabBarItem.title = title;
    if (imageName.length) {
        controllerVc.tabBarItem.image = [UIImage imageNamed:imageName];
        UIImage *temImage = [UIImage imageNamed:selectImageName];
        controllerVc.tabBarItem.selectedImage = [temImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self addChildViewController:controllerVc];
}

@end
