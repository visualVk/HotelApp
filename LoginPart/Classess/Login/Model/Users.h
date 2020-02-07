//
//  Users.h
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Users : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *passwordTwo;
@property (nonatomic, strong) NSString *idCard;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
