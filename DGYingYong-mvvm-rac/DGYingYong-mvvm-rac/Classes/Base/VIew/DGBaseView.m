//
//  DGBaseView.m
//  DGYingYong-mvvm-rac
//
//  Created by apple on 2018/9/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGBaseView.h"

@interface DGBaseView()
@property (assign, nonatomic) BOOL isLoadFinish;

@end
@implementation DGBaseView

-(instancetype)init{
    if (self = [super init]) {
        if (!self.isLoadFinish) {
            
            [self DG_setUpSubViews];
            [self DG_bindViewModel];
            
            self.isLoadFinish = YES;
        }
    }
    return self;
}
-(instancetype)initWithViewModel:(id<DGBaseViewModelProtocol>)viewModel{
    DGBaseView *baseView = [[DGBaseView alloc] init];
    if (!self.isLoadFinish) {
        
        [baseView DG_setUpSubViews];
        [baseView DG_bindViewModel];
        
        self.isLoadFinish = YES;
    }
    return baseView;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    if (!self.isLoadFinish) {
        
        [self DG_setUpSubViews];
        [self DG_bindViewModel];
        
        self.isLoadFinish = YES;
    }
}

- (void)DG_addSubViews{}
- (void)DG_bindViewModel{}
- (void)DG_getData{}

@end
