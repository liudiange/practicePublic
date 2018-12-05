//
//  NSDataAdditions.h
//  TapKit
//
//  Created by Kevin on 5/22/14.
//  Copyright (c) 2014 Tapmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (TapKit)

///-------------------------------
/// Hash
///-------------------------------

- (NSString *)tk_MD5HashString;

- (NSString *)tk_SHA1HashString;

@end
