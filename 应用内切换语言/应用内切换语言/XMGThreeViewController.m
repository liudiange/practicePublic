//
//  XMGThreeViewController.m
//  应用内切换语言
//
//  Created by apple on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XMGThreeViewController.h"

@interface XMGThreeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation XMGThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.nameLable.text = DGLocaLized(@"apple");
}


@end
