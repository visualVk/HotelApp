//
//  Users.m
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "Users.h"
@implementation Users

- (instancetype)init {
    self = [super init];
    if (self) {
        NSDictionary *dic  = [SAMKeychain accountsForService:USERIDENTIFY].lastObject;
        NSString *username = dic[@"acct"];
        NSString *password = [SAMKeychain passwordForService:USERIDENTIFY account:username];
        NSLog(@"{%@}", [dic description]);
        self.username = username;
        self.password = password;
    }
    return self;
}

@end
