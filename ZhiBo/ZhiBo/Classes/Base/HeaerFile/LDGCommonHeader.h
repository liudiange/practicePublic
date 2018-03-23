//
//  LDGCommonHeader.h
//  ZhiBo
//
//  Created by apple on 2018/3/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef LDGCommonHeader_h
// oc 相关的库的调用
#ifdef __OBJC__
#define LDGCommonHeader_h
// 颜色
#define  LDG_RANDM_COLOR  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]
#define  LDG_RGB_COLOR(r,g,b)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define  LDG_RGBA_COLOR(r,g,b,a)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a/255.0]
#define  LDG_BACKGROUND_COLOR  [UIColor colorWithRed:(211/255.0) green:(211/255.0) blue:(211/255.0) alpha:1.0]
// 屏幕大小
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
// 打印输出的log
#ifdef DEBUG
#define LDGLog(...) NSLog(__VA_ARGS__)
#else
#define LDGLog(...)
#endif
// 其他的宏
#define LDGLOGINFUNCTION XMGLOG(@"%s",__func__);



#endif
#endif

