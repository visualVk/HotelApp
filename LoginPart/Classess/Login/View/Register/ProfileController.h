//
//  ProfileController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "Users.h"
@interface ProfileController : QMUICommonTableViewController
@property (nonatomic, strong) Users *users;
@end
