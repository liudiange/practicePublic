//
//  main.m
//  DGTools
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (argc == 1) {
            printf("-l 显示用户的名字\n");
            printf("-e 显示用户的昵称\n");
            printf("-d 显示已经删除的用户\n");
            printf("-f 显示添加的好友\n");
            return 0;
        }
        if (strcmp(argv[1], "-l") == 0) {
            printf("我的名字是目前运行时\n");
            return 0;
        }else if (strcmp(argv[1], "-e") == 0){
            printf("我的昵称是北京老布鞋\n");
            return 0;
        }else if (strcmp(argv[1], "-d") == 0){
            printf("删除的用户是:啦啦啦\n");
            return 0;
        }else if (strcmp(argv[1], "-f") == 0){
            printf("添加的好友是:龙卷风\n");
            return 0;
        }else{
            printf("-l 显示用户的名字\n");
            printf("-e 显示用户的昵称\n");
            printf("-d 显示已经删除的用户\n");
            printf("-f 显示添加的好友\n");
        }
        return 0;
    }
}
