//
//  SecondViewController.m
//  strong 和 weak
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (copy, nonatomic) NSString *name;

@end
@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    __weak typeof(self)weakSelf = self;
    self.myblcok = ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.name = @"asdasdasd";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"weakSelf.name -- %@",strongSelf.name);
        });
    };
}
-(void)buttonAction{
    if (self.myblcok) {
        self.myblcok();
    }
   
}
-(void)dealloc {
    
    NSLog(@"zxczxczxczxczxc  对象被销毁了");
    
}
@end
