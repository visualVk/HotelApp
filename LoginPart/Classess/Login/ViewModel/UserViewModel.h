//
//  UserViewModel.h
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "Users.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserViewModel : NSObject
@property (nonatomic, strong) Users *users;
@property (nonatomic, strong) RACCommand *requestBtnCommond;
@end

NS_ASSUME_NONNULL_END
