//
//  model.h
//  strong 和 weak
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface model : NSObject

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableDictionary *dic;

@end
