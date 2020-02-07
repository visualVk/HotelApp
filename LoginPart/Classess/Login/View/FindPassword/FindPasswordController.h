//
//  FindPasswordController.h
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface FindPasswordController : QMUICommonViewController
@property(nonatomic, strong) QMUITextField *phoneNumTX;
@property(nonatomic, strong) QMUITextField *codeTX;
@property(nonatomic, strong) QMUIButton *codeBtn;
@property(nonatomic, strong) QMUIButton *nextBtn;
@end
