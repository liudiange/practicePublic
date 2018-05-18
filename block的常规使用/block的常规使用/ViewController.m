//
//  ViewController.m
//  block的常规使用
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "myView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    myView *obtainView = [[[NSBundle mainBundle]loadNibNamed:@"myView" owner:nil options:nil] lastObject];
    obtainView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    obtainView.myBlock = ^(int x, int y) {
        int sum = x + y;
        NSLog(@"%d",sum);
        
    };
    [self.view addSubview:obtainView];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    buttonAction();
}
void (^buttonAction)() = ^{
    NSLog(@"大哥我开始在里边执行方法了");
};

@end
