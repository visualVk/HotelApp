//
//  TextFieldCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface TextFieldCell : QMUITableViewCell
@property(nonatomic, strong) QMUITextField *textField;
@property(nonatomic, strong) QMUILabel *label;
@end
