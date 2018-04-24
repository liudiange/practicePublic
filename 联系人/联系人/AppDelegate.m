//
//  AppDelegate.m
//  联系人
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registAddressAuthor];
    return YES;
}

- (void)registAddressAuthor{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还没有决定能不能访问这个他的联系人数据库");
        }
            break;
        case CNAuthorizationStatusRestricted:
        {
            NSLog(@"不能访问联系人的数据库。而且用户不能在设置中改变这个状态");
        }
            break;
        case CNAuthorizationStatusDenied:
        {
            NSLog(@"用户拒绝访问了");
        }
            break;
        case CNAuthorizationStatusAuthorized:
        {
            NSLog(@"用户同意了");
        }
            break;
            
        default:
            break;
    }
}


@end
