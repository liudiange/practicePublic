//
//  LDGMenuTextField.m
//  UIMenuController 练习
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGMenuTextField.h"
#import <objc/message.h>

@implementation LDGMenuTextField
/**
 代码创建

 @param frame frame
 @return 对象本身
 */
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
/**
 初始化

 @param aDecoder aDecoder
 @return 本身
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
/**
 xib创建
 */
-(void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}
/**
 初始化
 */
- (void)setUp{
    UITapGestureRecognizer *longPressGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    [self addGestureRecognizer:longPressGes];
}

/**
 长按手势的点击事件

 */
- (void)longPressAction {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.arrowDirection = UIMenuControllerArrowDown;
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(myCopy:)];
    UIMenuItem *pasteItem = [[UIMenuItem alloc] initWithTitle:@"粘贴" action:@selector(myPaste:)];
    UIMenuItem *cutItem = [[UIMenuItem alloc] initWithTitle:@"剪切" action:@selector(myCut:)];
    menuController.menuItems = @[copyItem,pasteItem,cutItem];
    // 设置显示的位置（如果高度和）// 经过自己试用（发现设置 x y w 都是有效果的 其他的h 是没有效果的）
    [menuController setTargetRect:CGRectMake(0, 0, 200, 10) inView:self];
    // 显示出来
    [menuController setMenuVisible:YES];
    
    // 获取他的成员变量
//    unsigned int count;
//    Ivar *bigIvar = class_copyIvarList([UIMenuController class], &count);
//    for (int index = 0; index < count; index ++) {
//        Ivar smallIvar = bigIvar[index];
//        const char *charName = ivar_getName(smallIvar);
//        NSString *str =  [NSString stringWithUTF8String:charName];
//        NSLog(@"str --- %@",str);
//    }
//    free(bigIvar);
    // 获取他的属性
//    unsigned int count;
//    objc_property_t *propertyList = class_copyPropertyList([UIMenuController class], &count);
//    for (int index = 0; index < count; index ++) {
//        const char *charName = property_getName(propertyList[index]) ;
//        NSString *str =  [NSString stringWithUTF8String:charName];
//        NSLog(@"str --- %@",str);
//    }
}

/**
 让父空件成为第一响应者

 @return 是否成为第一响应者 （必须返回yes，否则不会出现）
 */
-(BOOL)canBecomeFirstResponder {
    return YES;
}
/**
 这个方法是允许什么方法实现

 @param action 活动事件
 @param sender 事件
 @return 是否可以执行
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(myCopy:)) {
        return YES;
    }else if (action == @selector(myPaste:)){
        return YES;
    }else if (action == @selector(myCut:)){
        return YES;
    }else if (action == @selector(copy:)){ //写上这个就增加了系统的 copy属性,但是要自己实现否则没有效果
        return YES;
    }
    return NO;
}
/**
 复制

 @param controller 对象
 */
- (void)myCopy:(UIMenuController *)controller {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
    
}
/**
 粘贴
 
 @param controller 对象
 */
- (void)myPaste:(UIMenuController *)controller {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    self.text = [self.text stringByAppendingString:pasteBoard.string];
}
/**
 剪切
 
 @param controller 对象
 */
- (void)myCut:(UIMenuController *)controller {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
    self.text = nil;
}


@end
