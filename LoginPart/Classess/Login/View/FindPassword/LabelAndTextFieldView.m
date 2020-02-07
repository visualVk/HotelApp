//
//  LabelAndTextFieldView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LabelAndTextFieldView.h"
#import "NSObject+BlockSEL.h"
#define addView(pa, sub) [pa addSubview:sub]

@implementation LabelAndTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - 生成布局
- (void)generateRootView {
  __weak __typeof(self) weakSelf = self;
  self.labelTitle                = @"";
  self.label                     = [QMUILabel new];
  self.textField                 = [QMUITextField new];
  self.button                    = [QMUIButton new];
  UIView *view                   = [UIView new];
  addView(self, view);
  addView(view, self.label);
  addView(view, self.textField);
  addView(view, self.button);
  self.backgroundColor     = [UIColor clearColor];
  view.qmui_borderPosition = QMUIViewBorderPositionBottom;
  view.qmui_borderColor    = UIColor.qd_separatorColor;
  // textfield
  self.textField.backgroundColor   = [UIColor clearColor];
  self.textField.font              = UIFontMake(16);
  self.textField.placeholder       = @"名字";
  self.textField.borderStyle       = UITextBorderStyleNone;
  self.textField.returnKeyType     = UIReturnKeyNext;
  self.textField.textContentType   = UITextContentTypePassword;
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
        weakSelf.label.text = weakSelf.labelTitle;
      } else {
        weakSelf.label.text = @"";
      }
    }
                    completion:nil];
  }];
  // button
  [self.button setTitle:@"显示" forState:UIControlStateNormal];
  [self.button addTarget:self
                  action:[self selectorBlock:^(id _Nonnull args) {
    if (![weakSelf.textField isSecureTextEntry]) {
      self.button.titleLabel.text = @"显示";
      [self.button setTitle:@"显示" forState:UIControlStateNormal];
    } else {
      self.button.titleLabel.text = @"隐藏";
      [self.button setTitle:@"隐藏" forState:UIControlStateNormal];
    }
    weakSelf.textField.secureTextEntry = !weakSelf.textField.secureTextEntry;
  }]
        forControlEvents:UIControlEventTouchUpInside];
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.offset(10);
    make.right.offset(-10);
    make.bottom.offset(-5);
  }];
  
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(view.mas_top);
    make.left.equalTo(view.mas_left);
  }];
  
  [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view.mas_left);
    make.width.greaterThanOrEqualTo(view.mas_width).multipliedBy(4.0 / 5);
    make.top.equalTo(weakSelf.label.mas_bottom).offset(5);
    make.bottom.equalTo(view.mas_bottom).offset(-5);
  }];
  
  [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.textField.mas_top);
    make.bottom.equalTo(weakSelf.textField.mas_bottom);
    make.leading.equalTo(weakSelf.textField.mas_trailing);
    make.trailing.equalTo(weakSelf.mas_trailing).offset(-10);
  }];
}


@end
