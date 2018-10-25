
//
//  DGEssenceTopicPresenter.m
//  BaiSiMvp
//
//  Created by apple on 2018/10/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DGEssenceTopicPresenter.h"
#import "DGEssenceTopicModel.h"
#import "DGTopicModel.h"

@interface DGEssenceTopicPresenter ()

@property (weak, nonatomic) id<DGEssenceTopicProtocol> mainView;
@property (strong, nonatomic) DGEssenceTopicModel *topicModel;

@end
@implementation DGEssenceTopicPresenter

/**
 获取view
 
 @param view view
 */
-(void)attchView:(id <DGEssenceTopicProtocol>)view{
    
    self.mainView = view;
}
/**
 获取数据
 */
- (void)fetchData{
    
    [self.mainView showLoadAnimation];
    self.topicModel = [[DGEssenceTopicModel alloc] init];
        @weakify(self);
    [self.topicModel requestWithType:(DGTopicType)[self.mainView fetchTopicType] complete:^(DGBaseHttpModel * _Nonnull model) {
        @strongify(self);
        [self.mainView hideLoadAnimation];
        if ([model.successCode isEqualToString:DG_Success_Code]) {
            NSArray *modelArray = [DGTopicModel mj_objectArrayWithKeyValuesArray:model.serverData[@"list"]];
            [self.mainView fetch:modelArray];
        }else{
            [self.mainView fetch:nil];
        }
    }];
    
    
}


@end
