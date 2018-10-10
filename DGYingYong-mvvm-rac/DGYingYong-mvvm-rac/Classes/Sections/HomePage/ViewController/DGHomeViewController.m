//
//  DGHomeViewController.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGHomeViewController.h"
#import "DGHomeView.h"
#import "DGHomeViewModel.h"


@interface DGHomeViewController ()

@property(weak,nonatomic) IBOutlet DGHomeView  *homeView;
@property (strong, nonatomic) DGHomeViewModel *homeViewModel;


@end

@implementation DGHomeViewController
-(DGHomeViewModel *)homeViewModel {
    if (!_homeViewModel) {
        _homeViewModel = [[DGHomeViewModel alloc] init];
    }
    return _homeViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)DG_bindViewModel{
    
    // geiview设置viewModel
    [self.homeView dg_setViewModel:self.homeViewModel];
    [self.homeView DG_bindViewModel];
    
}
-(void)DG_getData{
    
    [self.homeView DG_getData];
}

@end
