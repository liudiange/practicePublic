//
//  XMGTwoViewController.m
//  应用内切换语言
//
//  Created by apple on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XMGTwoViewController.h"

@interface XMGTwoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation XMGTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLable.text = DGLocaLized(@"apple");
}


@end
