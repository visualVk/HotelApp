//
//  PrefixPhoneController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface PrefixPhoneController : QMUICommonTableViewController
@property (nonatomic, strong) RACSignal *requestSignal;
@property (nonatomic, strong) void (^SelectedBlock)(NSString *textContent);
@end
