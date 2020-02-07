//
//  TextFieldCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TextFieldCell.h"
#define addView(parent, subview) [parent addSubview:subview]

@implementation TextFieldCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  __weak __typeof(self) weakSelf = self;
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  UIView *view        = [UIView new];
  self.textField      = [QMUITextField new];
  self.label          = [QMUILabel new];
  addView(self, view);
  addView(view, self.label);
  addView(view, self.textField);
  self.textField.backgroundColor   = [UIColor clearColor];
  self.backgroundColor             = [UIColor clearColor];
  view.qmui_borderPosition         = QMUIViewBorderPositionBottom;
  view.qmui_borderColor            = UIColor.blackColor;
  self.textField.font              = UIFontMake(16);
  self.textField.placeholder       = @"名字";
  self.textField.borderStyle       = UITextBorderStyleNone;
  self.textField.returnKeyType     = UIReturnKeyNext;
  self.textField.maximumTextLength = 10;
  // label
  self.label.text = @"";
  [[[self.textField.rac_textSignal map:^id _Nullable(NSString *_Nullable value) {
    if ([@"" isEqualToString:value])
      return @(false);
    else if (!value)
      return @(false);
    return @(true);
  }] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
    [UIView transitionWithView:weakSelf.label
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
      if (x.boolValue) {
        weakSelf.label.text = weakSelf.textField.placeholder;
      } else {
        weakSelf.label.text = @"";
      }
    }
                    completion:nil];
  }];
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.offset(10);
    make.right.offset(-10);
    make.bottom.offset(-5);
  }];
  
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(view.mas_top);
    make.left.equalTo(view.mas_left).offset(10);
  }];
  
  [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view.mas_left);
    make.right.equalTo(view.mas_right);
    make.top.equalTo(weakSelf.label.mas_bottom);
    make.bottom.equalTo(view.mas_bottom).offset(-5);
  }];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
