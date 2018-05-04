//
//  SecondViewController.m
//  拦截系统的pop
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SecondViewController.h"
#import <objc/message.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIGestureRecognizer class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *str =  @(ivar_getName(ivar));
        NSLog(@"str -- %@",str);
    }
    free(ivars);
    NSArray *array =  [self.navigationController.interactivePopGestureRecognizer valueForKey:@"_targets"];
    NSLog(@"数组 -- %@",array);
    
    NSDictionary *dic = array[0];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:[dic valueForKey:@"target"] action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGes];

    
}
@end
