//
//  UserViewModel.m
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "UserViewModel.h"
#import "UserApi.h"
@implementation UserViewModel

- (instancetype)init {
    self = [super init];
    if (self) { [self viewBindModel]; }
    return self;
}

- (void)viewBindModel {
    // user
    self.users = [[Users alloc] init];
    
    self.requestBtnCommond =
    [[RACCommand alloc] initWithSignalBlock:^RACSignal *_Nonnull(id _Nullable input) {
        RACSignal *requestSignal = [RACSignal
                                    createSignal:^RACDisposable *_Nullable(id<RACSubscriber> _Nonnull subscriber) {
            [[RequestUtils shareManager] RequestPostWithUrl:FINDUSER
                                                     Object:self.users
                                                    Success:^(NSDictionary *_Nullable dict) {
                self.users = [Users mj_objectWithKeyValues:dict];
                [subscriber sendNext:self.users];
                [SAMKeychain setPassword:self.users.password
                              forService:USERIDENTIFY
                                 account:self.users.username];
                [subscriber sendCompleted];
            }
                                                    Failure:^(NSError *_Nullable err) {
                [subscriber sendError:err];
                [subscriber sendCompleted];
            }];
            return [RACDisposable disposableWithBlock:^{ NSLog(@"signal disposed!"); }];
        }];
        return requestSignal;
    }];
}

@end
