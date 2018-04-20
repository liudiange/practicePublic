//
//  ViewController.m
//  strong 和 weak
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "myView.h"
#import "model.h"
#import "commonModel.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) model *myModel;
@property (weak, nonatomic) commonModel *mycommonModel;
//@property (strong, nonatomic) SecondViewController *secondVc;

@end
@implementation ViewController

@dynamic catName;
@synthesize dogName = _dogName;

-(void)setCatName:(NSString *)catName{
    _catName = catName;
}
-(NSString *)catName{
    if (_catName.length == 0) {
        return @"asdasdasd";
    }
    return _catName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    commonModel *mycommonModel = [[commonModel alloc] init];
//    mycommonModel.name = @"123";
//    mycommonModel.nickName = @"456";
//
//    model *mymodel = [[model alloc] init];
//    mymodel.name = @"zhangsan";
//    mymodel.dic = [NSMutableDictionary dictionaryWithDictionary:@{
//                                                                  @"name" : @"hahha",  @"data" : mycommonModel
//                                                                  }];
//
//
//    // 1.此时
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:mymodel];
//
//    NSLog(@"array --- %@",[array firstObject]);
//    NSMutableArray *mArray = [array mutableCopy];
//    NSLog(@"mArray --- %@",[mArray firstObject]);
//
//    // 2.改变
//    self.myModel = [mArray firstObject];
//    self.myModel.name = @"xiaosan";
//
//    NSLog(@"改变后 array --- %@",[array firstObject]);
//    NSLog(@"改变后 mArray --- %@",[mArray firstObject]);
//
//    // 改变 字典
//    self.mycommonModel = self.myModel.dic[@"data"];
//    self.mycommonModel.name = @"1111111";
//    NSLog(@"改变 字典后 array --- %@",[array firstObject]);
//    NSLog(@"改变 字典后 mArray --- %@",[mArray firstObject]);

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
-(void)buttonAction{
    
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
////    self.secondVc = secondVc;
////
//     secondVc.myblcok = ^{
//        self.myModel.name = @"asdasdasd";
//    };
 
    
    
   
}
@end
