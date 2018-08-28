//
//  ViewController.m
//  rac的简单使用
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (assign, nonatomic) CGPoint startP;
@property (strong, nonatomic) UIView *corverView;
@property (strong, nonatomic) UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *commonView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 1.信号
//   RACSignal *singnal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//       // 订阅信号
//       [subscriber sendNext:@"老夫发信号了奥"];
//       return nil;
//    }];
//   RACDisposable *dispsable = [singnal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"在这里接受到了。哈哈哈 %@",x);
//    }];
//    // 销毁
//    [dispsable dispose];
    
  
    // 2.subRACSubject 代替代理
//    RACSubject *subject = [RACSubject subject];
//    [subject subscribeNext:^(id  _Nullable x) {
//        NSLog(@"别动我 我接受到东西了 : %@",x);
//    }];
//    [subject sendNext:@"asdasdasds"];

    // 3.racTuple 元组
//    RACTuple *tuple1 = [RACTuple tupleWithObjects:@(10),@"asdasdsa",@"asd", nil];
//    RACTuple *tuple2 = [RACTuple tupleWithObjectsFromArray:@[@"asdasd",@"288",@"asda"]];
//    RACTuple *tuple3 = RACTuplePack(@"asdasd",@"asdas");
//    NSLog(@"%@ ==== %@ ====== %@ =====%@",[tuple1 first],[tuple2 last],tuple2[1],[tuple3 first]);
    
    
    // 4.便利数组和字典
//    NSArray *array = @[@"asdasd",@"asdasd",@10];
//    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@" ----- %@",x);
//    }];
//
//    NSDictionary *dic = @{
//                          @"nanme" : @"jack",
//                          @"age" : @(10),
//                          @"weight" : @(10)
//                          };
//    [dic.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
//
//        RACTupleUnpack(NSString *key,id value) = x;
//        NSLog(@"%@ ++++ %@",key,value);
//    }];
    
    // 将数组中的值全部替换为0 (不改变原来的数组)
//    NSArray *array = @[@"asdasd",@"name",@"asdjjj"];
//    NSArray *obtainArray1 = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
//        return @"xiaobaobei";
//    }] array];
//    NSLog(@"%@ ---- %@",array,obtainArray1);
//    NSArray *ontainArray2 = [[array.rac_sequence mapReplace:@"asdasdasd"] array];
//    NSLog(@"%@ +++++ %@",array,ontainArray2);

     // 5.uitextfield 的监控
    
//    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"x === %@",x);
//    }];
//    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//
//        return value.length > 3;
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"x ==== %@",x);
//    }];
    
    // 6.监听button的事件
    
//    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//        NSLog(@"lalalla : %@",x);
//    }];
    
    // 7.登录按钮实时监听
    
//        @weakify(self);
//    RAC(self.button,enabled) = [RACSignal combineLatest:@[self.nameTextfield.rac_textSignal ,self.textField.rac_textSignal] reduce:^id _Nullable{
//        @strongify(self);
//        return @(self.nameTextfield.text.length && self.textField.text.length);
//    }];
    
      // 8.监听通知事件,可以省去在dealloc中清楚通知
    
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//
//        NSLog(@"x ===== %@",x);
//    }];
    
    // 9.代替delegate
//    [[self.commonView rac_signalForSelector:@selector(buttonClick)] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    // 10.代替观察者 可以省去在dealloc中清楚通知
//    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[self.view rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionOld observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];

    // 11 代替定时器
    
//         @weakify(self);
//    [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//         NSLog(@"x ==== : %@",x);
//         @strongify(self);
//    }];
    

}





@end
