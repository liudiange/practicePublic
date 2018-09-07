//
//  ViewController.m
//  封装一个简单加载动画的控件
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DGShowView.h"
#import "DGToastViewObject.h"
#import "UIView+DGEmptyView.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.textField becomeFirstResponder];
//
//    [DGShowView DG_showAnimationView:self.view];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
//            [DGShowView DG_hideViewInView:self.view];
//        }];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [DGShowView DG_showAnimationViewWithType:DGAnimationType1 withDefaultY:200 inView:self.view];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [DGShowView DG_hideViewInViewWithType:DGAnimationType1 inView:self.view];
//    });
    
    
//    [DGToastViewObject DG_showToastString:@"asdasdasdasdasd" withType:DGToastTypeSuccess withDuration:10.0];
//    [DGToastViewObject DG_showToastString:@"asdasdasdasdasd" withType:DGToastTypeFail];
    
//    for (NSInteger index = 0; index < [UIApplication sharedApplication].windows.count; index++) {
//        UIWindow *window = [UIApplication sharedApplication].windows[index];
//        NSLog(@"index === %zd",index);
//         NSLog(@"window === %@",[UIApplication sharedApplication].keyWindow);
//        if (window == [UIApplication sharedApplication].delegate.window) {
//            NSLog(@"delegate.window+++++++++%zd ===== %@",index,window);
//        }
//        if (window == [UIApplication sharedApplication].keyWindow) {
//            NSLog(@"keyWindow+++++++++%zd ===== %@",index,window);
//        }
//    }
    
    
    [self addDefaultView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 200, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}
-(void)addDefaultView{
    
    [self.view DG_addEmptyViewWithType:DGEmptyViewTypeNoData withDefaultY:0 checkBlock:^BOOL{
        
        return self.dataArray.count;
        
    } handleBlock:^(DGEmptyViewType type) {
        
        NSLog(@"开始重新加载数据了");
    }];
    [self.view DG_eddEmptyView:NO];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.dataArray removeAllObjects];
    [self.view DG_eddEmptyView:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            [self.dataArray addObject:@"asdasd"];
            [self.view DG_eddEmptyView:YES];
        }];
    });
    
}

@end
