//
//  ViewController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface LoginController : QMUICommonViewController
@property (nonatomic, strong) QMUITextField *usernameTX;
@property (nonatomic, strong) QMUITextField *passwordTX;
@property (nonatomic, strong) QMUIButton *registerBtn;
@property (nonatomic, strong) QMUIButton *findPasswordBtn;
@property (nonatomic, strong) QMUIButton *faceBtn;
@property(nonatomic, strong) QMUIButton *loginBtn;
@end
