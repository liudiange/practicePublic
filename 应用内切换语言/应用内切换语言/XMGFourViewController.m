//
//  XMGFourViewController.m
//  应用内切换语言
//
//  Created by apple on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XMGFourViewController.h"
#import "AppDelegate.h"

@interface XMGFourViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIButton *changeLanguageButton;

@end

@implementation XMGFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.nameLable.text = DGLocaLized(@"apple");
}
- (IBAction)changeLanguageAction:(UIButton *)sender {
    
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:AppKey];
    if ([language isEqualToString:@"zh-Hans"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppKey];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate *appDele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDele launchMethod];
    
    
    
}



@end
