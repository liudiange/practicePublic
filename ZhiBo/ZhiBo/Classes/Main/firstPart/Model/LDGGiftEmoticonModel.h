//
//  LDGGiftEmoticonModel.h
//  ZhiBo
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGGiftEmoticonModel : NSObject
//auth = 1;
//authInfo = "\U8fbe\U5230\U5c4c\U4e1d";
//bSdkUrl = "";
//bUrl = "";
//coin = 1000;
//detail = "";
//ext =                     {
//    weekly = 1;
//};
//gUrl = "https://file.qf.56.com/f/upload/photo/gift/pc/v2/gif/guaidanboluo-1.gif";
//id = 41302;
//img = "https://file.qf.56.com/f/upload/photo/giftNew/app/201711011057471509505067954.png";
//img2 = "https://file.qf.56.com/f/upload/photo/giftNew/app/201711011057531509505073711.png";
//isR = 1;
//mSdkUrl = "";
//mUrl = "";
//maxNum = 77;
//oCoin = 1000;
//pCid = 0;
//sType =                     {
//    hit = 1;
//    luxury = 1;
//};
//subject = "\U602a\U8bde\U83e0\U841d";
//time = 4160;
//type = 1;
//w2Url = "https://file.qf.56.com/f/upload/photo/gift/m/v2/webp2/guaidanboluo.webp";
//wUrl = "https://file.qf.56.com/f/upload/photo/gift/m/v2/webp/guaidanboluo.webp";
//zUrl = "https://file.qf.56.com/f/upload/photo/gift/m/v2/zip/guaidanboluo.zip";
//zUrl2 = "https://file.qf.56.com/f/upload/photo/gift/m/v2/zip/guaidanboluo.zip";

/**
 图片
 */
@property (copy, nonatomic) NSString *img2;
/**
 价格
 */
@property (assign, nonatomic) int coin;
/**
 标题
 */
@property (copy, nonatomic) NSString *subject;


@end
