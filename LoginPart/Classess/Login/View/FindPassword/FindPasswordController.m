//
//  FindPasswordController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "FindPasswordController.h"
#import "LogoView.h"
#import "NSObject+BlockSEL.h"
#import "ResetPasswordController.h"
#define addView(pa, sub) [pa addSubview:sub]
#define Height 1.0 / 30

@interface FindPasswordController ()
@property (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic, assign) NSInteger time;
@end

@implementation FindPasswordController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
  [self initListener];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"找回密码 1/2";
}

#pragma mark - 生成布局
- (void)generateRootView {
  __weak __typeof(self) weakSelf = self;
  LogoView *logoView             = [LogoView new];
  logoView.label.text            = @"验证手机号";
  UIView *codeView               = [UIView new];
  codeView.layer.cornerRadius    = 2;
  codeView.layer.borderColor     = UIColorSeparator.CGColor;
  codeView.layer.borderWidth     = PixelOne;
  addView(self.view, logoView);
  addView(self.view, self.phoneNumTX);
  addView(self.view, codeView);
  addView(codeView, self.codeTX);
  addView(codeView, self.codeBtn);
  addView(self.view, self.nextBtn);
  
  UIView *superview = self.view;
  [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_safeAreaLayoutGuideTop).offset(30);
    make.centerX.offset(0);
  }];
  
  [self.phoneNumTX mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(logoView.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  
  [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
    make.top.equalTo(weakSelf.phoneNumTX.mas_bottom).offset(10);
  }];
  
  [codeView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(codeView.mas_bottom);
    make.top.equalTo(codeView.mas_top);
  }];
  
  [self.codeTX mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(codeView.mas_leading);
    make.width.lessThanOrEqualTo(codeView.mas_width).multipliedBy(3.0 / 4);
  }];
  
  [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(weakSelf.codeTX.mas_trailing);
    make.trailing.equalTo(codeView.mas_trailing);
  }];
  
  [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(10);
    make.right.offset(-10);
    make.top.equalTo(codeView.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
}

#pragma mark - 初始化监听事件
- (void)initListener {
  __weak __typeof(self) weakSelf = self;
  // code button
  [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
   subscribeNext:^(__kindof UIControl *_Nullable x) {
    self.time = 60;
    // uibutton title需要通过setTitleColor方法修改
    [weakSelf.codeBtn setTitleColor:UIColor.qd_mainTextColor forState:UIControlStateDisabled];
    weakSelf.codeBtn.enabled = NO;
    weakSelf.codeBtn.titleLabel.text =
    [NSString stringWithFormat:@"请稍等%ld秒", weakSelf.time];
    [weakSelf.codeBtn setTitle:[NSString stringWithFormat:@"请稍等%ld秒", weakSelf.time]
                      forState:UIControlStateNormal];
    weakSelf.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
                           subscribeNext:^(NSDate *_Nullable x) {
      weakSelf.time--;
      NSString *textContent =
      (weakSelf.time > 0)
      ? [NSString stringWithFormat:@"请稍等%ld秒", weakSelf.time]
      : @"重新发送";
      weakSelf.codeBtn.titleLabel.text = textContent;
      if (weakSelf.time > 0) {
        weakSelf.codeBtn.enabled = NO;
        [weakSelf.codeBtn setTitle:textContent forState:UIControlStateDisabled];
      } else {
        //        weakSelf.codeBtn.titleLabel.textColor = UIColor.qd_tintColor;
        weakSelf.codeBtn.enabled = YES;
        [weakSelf.codeBtn setTitle:textContent forState:UIControlStateNormal];
        [self.disposable dispose];
      }
    }];
  }];
  // next button
  [self.nextBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    if (!self.codeTX.text || [@"" isEqualToString:self.codeTX.text]) {
      [QMUITips showWithText:@"请输入验证码" inView:weakSelf.view hideAfterDelay:2];
    } else {
      /// todo: 跳转到信息填写页面
      ResetPasswordController *rspController = [ResetPasswordController new];
      [weakSelf.navigationController pushViewController:rspController animated:YES];
    }
  }]
   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 懒加载
- (QMUITextField *)phoneNumTX {
  if (!_phoneNumTX) {
    _phoneNumTX                    = [QMUITextField new];
    _phoneNumTX.maximumTextLength  = 11;
    _phoneNumTX.font               = UIFontMake(16);
    _phoneNumTX.placeholder        = @"输入手机号";
    _phoneNumTX.layer.cornerRadius = 2;
    _phoneNumTX.layer.borderColor  = UIColorSeparator.CGColor;
    _phoneNumTX.layer.borderWidth  = PixelOne;
    _phoneNumTX.textInsets         = UIEdgeInsetsMake(0, 10, 0, 10);
    _phoneNumTX.keyboardType       = UIKeyboardTypeNumbersAndPunctuation;
    _phoneNumTX.clearButtonMode    = UITextFieldViewModeAlways;
  }
  return _phoneNumTX;
}

- (QMUITextField *)codeTX {
  if (!_codeTX) {
    _codeTX                   = [QMUITextField new];
    _codeTX.font              = UIFontMake(16);
    _codeTX.maximumTextLength = 5;
    _codeTX.placeholder       = @"输入验证码";
    _codeTX.textInsets        = UIEdgeInsetsMake(0, 10, 0, 10);
    _codeTX.keyboardType      = UIKeyboardTypeNumbersAndPunctuation;
    //    _codeTX.clearButtonMode   = UITextFieldViewModeAlways;
  }
  return _codeTX;
}

- (QMUIButton *)codeBtn {
  if (!_codeBtn) {
    _codeBtn                 = [QMUIButton new];
    _codeBtn.titleLabel.font = UIFontMake(16);
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
  }
  return _codeBtn;
}

- (QMUIButton *)nextBtn {
  if (!_nextBtn) {
    _nextBtn                 = [QDUIHelper generateDarkFilledButton];
    _nextBtn.titleLabel.font = UIFontMake(16);
    [_nextBtn setTitle:@"下一步，重置密码" forState:UIControlStateNormal];
  }
  return _nextBtn;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
  return YES;
}
@end
