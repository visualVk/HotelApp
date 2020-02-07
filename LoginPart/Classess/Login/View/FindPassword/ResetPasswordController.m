//
//  ResetPasswordController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ResetPasswordController.h"
#import "LabelAndTextFieldView.h"
#import "LogoView.h"
#import "MyScrollView.h"
#import "NSObject+BlockSEL.h"
#import "Users.h"
#define addView(pa, sub) [pa addSubview:sub]
#define Height 1.0 / 13

@interface ResetPasswordController () <QMUITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) LabelAndTextFieldView *passwordOneLFV;
@property (nonatomic, strong) LabelAndTextFieldView *passwordTwoLFV;
@property (nonatomic, strong) QMUILabel *passwordCompareLB;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) QMUIButton *resetAndLoginBtn;
@property (nonatomic, strong) Users *users;
@end

@implementation ResetPasswordController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.users = [Users new];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRoowView];
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
  self.title = @"找回密码 2/2";
}

#pragma mark - 生成布局
- (void)generateRoowView {
  __weak __typeof(self) weakSelf         = self;
  self.scrollView                        = [UIScrollView new];
  self.scrollView.delegate               = self;
  self.scrollView.scrollEnabled          = YES;
  self.scrollView.userInteractionEnabled = YES;
  //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
  //                 dispatch_get_main_queue(),
  //                 ^{ self.scrollView.contentSize = CGSizeMake(414, 1000); });
  self.view.userInteractionEnabled = YES;
  LogoView *logoView               = [LogoView new];
  logoView.label.text              = @"验证手机号";
  UIView *container                = [UIView new];
  addView(self.view, self.scrollView);
  addView(self.scrollView, container);
  addView(container, logoView);
  addView(container, self.passwordOneLFV);
  addView(container, self.passwordTwoLFV);
  addView(container, self.passwordCompareLB);
  addView(container, self.resetAndLoginBtn);
  
  UIView *superview = self.view;
  [container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.scrollView);
    make.width.equalTo(self.scrollView);
  }];
  
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_safeAreaLayoutGuideTop);
    make.left.right.offset(0);
    make.bottom.equalTo(superview.mas_safeAreaLayoutGuideBottom);
  }];
  
  [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(container.mas_top).offset(30);
    make.centerX.equalTo(container.mas_centerX).offset(0);
  }];
  
  [self.passwordOneLFV mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(container);
    make.top.equalTo(logoView.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  
  [self.passwordTwoLFV mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(container);
    make.top.equalTo(weakSelf.passwordOneLFV.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  
  [self.passwordCompareLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(weakSelf.passwordTwoLFV.mas_bottom);
    make.left.equalTo(container).offset(10);
    make.right.equalTo(container).offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(1.0 / 10);
  }];
  
  [self.resetAndLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(container).offset(10);
    make.right.equalTo(container).offset(-10);
    make.top.equalTo(weakSelf.passwordCompareLB.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(1.0 / 20);
  }];
  
  [container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.resetAndLoginBtn.mas_bottom);
  }];
}

#pragma mark - 初始化监听事件
- (void)initListener {
  RAC(self.users, password)    = self.passwordOneLFV.textField.rac_textSignal;
  RAC(self.users, passwordTwo) = self.passwordTwoLFV.textField.rac_textSignal;
  @weakify(self);
  [[[[RACSignal
      combineLatest:@[ RACObserve(self.users, password), RACObserve(self.users, passwordTwo) ]]
     map:^id _Nullable(RACTuple *tuple) {
    return @([self.users.password isEqualToString:self.users.passwordTwo]);
  }] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
    @strongify(self);
    if (!x.boolValue) {
      self.passwordCompareLB.text      = @"两次输入的密码不一致";
      self.passwordCompareLB.textColor = UIColorMakeWithHex(@"#F56C6C");
    } else {
      self.passwordCompareLB.textColor = UIColorMakeWithHex(@"#67C23A");
      self.passwordCompareLB.text      = @"密码强度仍可改进";
    }
  }];
  [self.resetAndLoginBtn addTarget:self
                            action:[self selectorBlock:^(id _Nonnull args) {
    @strongify(self);
    [self postUserInfo];
  }]
                  forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 懒加载
- (LabelAndTextFieldView *)passwordOneLFV {
  __weak __typeof(self) weakSelf = self;
  if (!_passwordOneLFV) {
    _passwordOneLFV                           = [LabelAndTextFieldView new];
    _passwordOneLFV.tag                       = 1001;
    _passwordOneLFV.labelTitle                = @"密码";
    _passwordOneLFV.textField.secureTextEntry = YES;
    _passwordOneLFV.textField.placeholder     = @"请输入密码";
    _passwordOneLFV.textField.delegate        = self;
    _passwordOneLFV.textField.qmui_keyboardWillShowNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf showKeyBoard:keyboardUserInfo]; };
    _passwordOneLFV.textField.qmui_keyboardWillHideNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf hideKeyBoard:keyboardUserInfo]; };
  }
  return _passwordOneLFV;
}

- (LabelAndTextFieldView *)passwordTwoLFV {
  __weak __typeof(self) weakSelf = self;
  if (!_passwordTwoLFV) {
    _passwordTwoLFV                           = [LabelAndTextFieldView new];
    _passwordTwoLFV.textField.secureTextEntry = YES;
    _passwordTwoLFV.tag                       = 1002;
    _passwordTwoLFV.labelTitle                = @"确认密码";
    _passwordTwoLFV.textField.placeholder     = @"请再一次输入密码";
    _passwordTwoLFV.textField.delegate        = self;
    _passwordTwoLFV.textField.qmui_keyboardWillShowNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf showKeyBoard:keyboardUserInfo]; };
    _passwordTwoLFV.textField.qmui_keyboardWillHideNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf hideKeyBoard:keyboardUserInfo]; };
  }
  return _passwordTwoLFV;
}

- (QMUILabel *)passwordCompareLB {
  if (!_passwordCompareLB) {
    _passwordCompareLB           = [QMUILabel new];
    _passwordCompareLB.font      = UIFontMake(16);
    _passwordCompareLB.text      = @"";
    _passwordCompareLB.textColor = UIColorMakeWithHex(@"#F56C6C");
  }
  return _passwordCompareLB;
}

- (QMUIButton *)resetAndLoginBtn {
  if (!_resetAndLoginBtn) {
    _resetAndLoginBtn = [QDUIHelper generateDarkFilledButton];
    [_resetAndLoginBtn setTitle:@"重置并登陆" forState:UIControlStateNormal];
    _resetAndLoginBtn.titleLabel.font = UIFontMake(16);
  }
  return _resetAndLoginBtn;
}
#pragma mark - text field代理
- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  UIView *superview        = textField.superview.superview.superview;
  NSInteger nextTag        = textField.superview.superview.tag + 1;
  QMUITextField *nextField = ((LabelAndTextFieldView *)[superview viewWithTag:nextTag]).textField;
  [textField resignFirstResponder];
  [nextField becomeFirstResponder];
  nextField.returnKeyType = UIReturnKeyDone;
  return YES;
}

#pragma mark - 键盘显示，table view content view的偏移
- (void)showKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf = self;
  CGRect keyBoardRect = [userInfo.originUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  weakSelf.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}

- (void)hideKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf   = self;
  weakSelf.scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)postUserInfo {
  [[RequestUtils shareManager] RequestPostWithUrl:@"findUser"
                                           Object:self.users
                                          Success:^(NSDictionary *_Nullable dict) { QMUILogInfo(@"post user info", @"success"); }
                                          Failure:^(NSError *_Nullable err) { QMUILogInfo(@"post user info", @"failure"); }];
}

@end
