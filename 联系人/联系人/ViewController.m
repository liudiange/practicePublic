//
//  ViewController.m
//  联系人
//
//  Created by apple on 2018/4/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>


@interface ViewController ()<CNContactPickerDelegate>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
//    contactVc.delegate = self;
//    [self presentViewController:contactVc animated:YES completion:nil];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [self getAddress:store];
        }
    }];
}

/**
 获取联系人

 @param store store
 */
- (void)getAddress:(CNContactStore *)store {
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey]];
    NSError *error = nil;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        [self.dataArray addObject:contact];
    }];
    for (CNContact *contact in self.dataArray) {
        for (CNLabeledValue<CNPhoneNumber*>* phone in contact.phoneNumbers) {
            CNPhoneNumber *phonNumber = (CNPhoneNumber *)phone.value;
            NSLog(@"phonNumber -- %@",phonNumber);
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

//#pragma mark - delegate
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
//
//    NSLog(@"+++++++++++++++++++");
//    NSLog(@"contact.givenName -- %@ contact.familyName - %@",contact.givenName,contact.familyName);
//
//    for (CNLabeledValue<CNPhoneNumber*>* phone in contact.phoneNumbers) {
//        CNPhoneNumber *phonNumber = (CNPhoneNumber *)phone.value;
//        NSLog(@"phone.label -- %@  phonNumber -- %@",phone.label,phonNumber);
//    }
//}

@end
