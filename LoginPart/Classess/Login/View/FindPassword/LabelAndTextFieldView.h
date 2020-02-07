//
//  LabelAndTextFieldView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelAndTextFieldView : UIView
@property (nonatomic, strong) QMUILabel *label;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) NSString *labelTitle;
@property (nonatomic, strong) QMUIButton *button;
@end
