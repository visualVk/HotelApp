//
//  TextFieldAndButtonCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface TextFieldAndButtonCell : QMUITableViewCell
@property(nonatomic, strong) QMUITextField *textField;
@property(nonatomic, strong) QMUIButton *button;
@property(nonatomic, strong) QMUILabel *label;
@property(nonatomic, strong) void (^clickListener)(void);
@end
