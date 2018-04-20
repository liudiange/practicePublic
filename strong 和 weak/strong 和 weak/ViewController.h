//
//  ViewController.h
//  strong 和 weak
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    @private
    
    __strong NSString *_catName;
    
}
@property (copy, nonatomic) NSString *catName;
@property (copy, nonatomic) NSString *dogName;

@property (copy, nonatomic) void (^testBlock)();



@end

