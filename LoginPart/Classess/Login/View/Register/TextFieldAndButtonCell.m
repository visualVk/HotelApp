//
//  TextFieldAndButtonCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TextFieldAndButtonCell.h"
#import "NSObject+BlockSEL.h"
#define addView(parent, subview) [parent addSubview:subview]
@implementation TextFieldAndButtonCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *view             = [UIView new];
  view.qmui_borderColor    = UIColor.blackColor;
  view.backgroundColor     = [UIColor clearColor];
  view.qmui_borderPosition = QMUIViewBorderPositionBottom;
  self.backgroundColor     = [UIColor clearColor];
  // button
  self.button                    = [QMUIButton new];
  __weak __typeof(self) weakSelf = self;
  [self.button addTarget:self
                  action:[self selectorBlock:^(id _Nonnull args) {
    if (![weakSelf.textField isFirstResponder]) {
      [UIView animateWithDuration:1
                       animations:^{ [weakSelf.textField becomeFirstResponder]; }];
    }
    if (weakSelf.textField.secureTextEntry) {
      weakSelf.button.titleLabel.text = @"隐藏";
      [weakSelf.button setTitle:@"隐藏" forState:UIControlStateNormal];
    } else {
      weakSelf.button.titleLabel.text = @"显示";
      [weakSelf.button setTitle:@"显示" forState:UIControlStateNormal];
    }
    weakSelf.textField.secureTextEntry = !weakSelf.textField.secureTextEntry;
    if (weakSelf.clickListener) { weakSelf.clickListener(); }
  }]
        forControlEvents:UIControlEventTouchUpInside];
  [self.button setTitle:@"显示" forState:normal];
  self.button.titleLabel.font    = UIFontMake(16);
  self.textField                 = [QMUITextField new];
  self.textField.placeholder     = @"label";
  self.textField.font            = UIFontMake(16);
  self.textField.borderStyle     = UITextBorderStyleNone;
  self.textField.textInsets      = UIEdgeInsetsMake(0, 10, 0, 10);
  self.textField.returnKeyType   = UIReturnKeyNext;
  self.textField.textContentType = UITextContentTypePassword;
  //  self.textField.keyboardType  = UIKeyboardTypeASCIICapable;
  //  if (@available(iOS 12.0, *)) { self.textField.textContentType = UITextContentTypeOneTimeCode;
  //  }
  self.textField.maximumTextLength = 15;
  // label
  self.label      = [QMUILabel new];
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
  addView(self, view);
  addView(view, self.textField);
  addView(view, self.button);
  addView(view, self.label);
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.offset(10);
    make.right.offset(-10);
    make.bottom.offset(0);
  }];
  
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(view.mas_top);
    make.left.equalTo(view.mas_left).offset(10);
  }];
  
  [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.label.mas_bottom);
    make.left.equalTo(view.mas_left);
    make.width.mas_greaterThanOrEqualTo(view.mas_width).multipliedBy(4.0 / 5);
    make.bottom.equalTo(view.mas_bottom).offset(-10);
  }];
  [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.textField.mas_top);
    make.leading.equalTo(self.textField.mas_trailing);
    make.right.equalTo(view.mas_right);
    make.bottom.equalTo(view.mas_bottom).offset(-10);
  }];
}
@end
