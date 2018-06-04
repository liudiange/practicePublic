//
//  LDGDetailMessageTool.m
//  ZhiBo
//
//  Created by apple on 2018/6/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LDGDetailMessageTool.h"

@implementation LDGDetailMessageTool
/**
 处理文本消息
 
 @param textM 消息的message
 @return 我们想要的字符串
 */
+ (NSAttributedString *)handleTextMessage:(TextMessage *)textM{
    NSString *str = [NSString stringWithFormat:@"%@ : %@",textM.user.name,textM.text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:textM.user.name];
    [attrStr addAttributes:@{
                             NSForegroundColorAttributeName : [UIColor greenColor]
                             } range: range];
    // 正则表达式
    NSString *pattern = @"\\[.*?\\]";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *regexArray = [expression matchesInString:str options:1 range:NSMakeRange(0, attrStr.string.length)];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    // 图文混排
    for (NSInteger index = regexArray.count -1; index >= 0; index --) {
        NSTextCheckingResult *checkResult = regexArray[index];
        NSString *imageName = [attrStr.string substringWithRange:checkResult.range];
        UIImage *image = [UIImage imageNamed:imageName];
        if (!image) {
            continue;
        }else{
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = image;
            attachment.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
            NSAttributedString *imageAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
            [attrStr replaceCharactersInRange:checkResult.range withAttributedString:imageAttrStr];
        }
    }
    return [attrStr copy];
    
}
/**
 处理礼物的消息
 
 @param giftM 礼物
 @return 对象本身
 */
+ (NSAttributedString *)handleGiftMessage:(GiftMessage *)giftM{
    NSString *textStr = [NSString stringWithFormat:@"%@ 赠送给主播 %@",giftM.user.name,giftM.giftURL];
    NSRange userNameRange = [textStr rangeOfString:giftM.user.name];
    NSRange giftNameRange = [textStr rangeOfString:giftM.giftURL];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    [attrStr addAttributes:@{
                             NSForegroundColorAttributeName : [UIColor greenColor]
                             } range: userNameRange];
    NSString *imageName = [[SDImageCache sharedImageCache] defaultCachePathForKey:giftM.giftURL];
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
        NSAttributedString *imageAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [attrStr replaceCharactersInRange:giftNameRange withAttributedString:imageAttrStr];
    }else{
        [attrStr replaceCharactersInRange:giftNameRange withString:@""];
    }
    return [attrStr copy];
}
@end
