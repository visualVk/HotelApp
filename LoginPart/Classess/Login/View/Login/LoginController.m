//
//  ViewController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LoginController.h"
#import "FaceController.h"
#import "FindPasswordController.h"
#import "LogoView.h"
#import "MainTabController.h"
#import "NSObject+BlockSEL.h"
#import "RegisterController.h"
#import "UserApi.h"
#import "Users.h"
#define addSubView(subView) [self.view addSubview:subView]
#define Height 1.0 / 30
typedef void (^clickBlock)(void);
@interface LoginController () <QMUITextFieldDelegate>
@property (nonatomic, strong) Users *users;
@end

@implementation LoginController
- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}
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
  [self generateRootView];
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
  self.title = @"Login";
}

#pragma mark - 加载布局
- (void)generateRootView {
  LogoView *logoView = [LogoView new];
  addSubView(logoView);
  addSubView(self.usernameTX);
  addSubView(self.passwordTX);
  addSubView(self.loginBtn);
  addSubView(self.registerBtn);
  addSubView(self.findPasswordBtn);
  addSubView(self.faceBtn);
  
  // init click listener
  [self initListener];
  
  UIView *superview = self.view;
  [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_safeAreaLayoutGuideTop).offset(30);
    make.centerX.offset(0);
  }];
  [self.usernameTX mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(logoView.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.passwordTX mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.usernameTX.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.passwordTX.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
    make.leading.equalTo(superview.mas_leading).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
    make.trailing.equalTo(superview.mas_trailing).offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.offset(0);
    make.bottom.equalTo(superview.mas_safeAreaLayoutGuideBottom).offset(-5);
  }];
}

#pragma mark - 初始化监听事件
- (void)initListener {
  __weak __typeof(self) weakSelf = self;
  //    login button
  [self.loginBtn addTarget:self
                    action:@selector(login:)
          forControlEvents:UIControlEventTouchUpInside];
  //    face recognition
  [self.faceBtn addTarget:self
                   action:[self selectorBlock:^(id _Nonnull arg) {
    FaceController *faceController = [FaceController new];
    QMUINavigationController *nav  = [[QMUINavigationController alloc]
                                      initWithRootViewController:faceController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    faceController.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                                       qmui_backItemWithTarget:self
                                                       action:[self selectorBlock:^(id _Nonnull args) {
      [nav dismissViewControllerAnimated:YES completion:nil];
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf presentViewController:nav animated:YES completion:nil];
    });
  }]
         forControlEvents:UIControlEventTouchUpInside];
  // register
  [self.registerBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    RegisterController *registerController = [RegisterController new];
    QMUINavigationController *nav          = [[QMUINavigationController alloc]
                                              initWithRootViewController:registerController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    registerController.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                                           qmui_backItemWithTarget:self
                                                           action:[self selectorBlock:^(id _Nonnull args) {
      [nav dismissViewControllerAnimated:YES completion:nil];
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf presentViewController:nav animated:YES completion:nil];
    });
  }]
   forControlEvents:UIControlEventTouchUpInside];
  // find password button
  [self.findPasswordBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    FindPasswordController *fpController = [FindPasswordController new];
    QMUINavigationController *nav =
    [[QMUINavigationController alloc] initWithRootViewController:fpController];
    nav.modalPresentationStyle                    = UIModalPresentationFullScreen;
    fpController.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                                     qmui_backItemWithTarget:self
                                                     action:[self selectorBlock:^(id _Nonnull args) {
      [nav dismissViewControllerAnimated:YES completion:nil];
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf presentViewController:nav animated:YES completion:nil];
    });
  }]
   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击事件
- (void)login:(QMUIButton *)btn {
  self.users.username = self.usernameTX.text;
  self.users.password = self.passwordTX.text;
  //暂时直接跳转
  MainTabController *mainTab  = [MainTabController new];
  mainTab.modalPresentationStyle = UIModalPresentationFullScreen;
  [self presentViewController:mainTab animated:YES completion:^{}];
  [[RequestUtils shareManager] RequestPostWithUrl:FINDUSER
                                        Parameter:[DictUtils Object2Dict:self.users]
                                          Success:^(NSDictionary *_Nullable dict) {
    self.users = [Users mj_objectWithKeyValues:dict];
    [SAMKeychain setPassword:self.users.password
                  forService:USERIDENTIFY
                     account:self.users.username];
    QMUILogInfo(@"login", @"login success,return value:{%@}", [dict description]);
  }
                                          Failure:^(NSError *_Nullable err) {
    QMUILogWarn(@"login", @"login error:%@", [err description]);
  }];
}

#pragma mark - 懒加载
- (QMUITextField *)usernameTX {
  if (!_usernameTX) {
    _usernameTX                    = [QMUITextField new];
    _usernameTX.font               = UIFontMake(16);
    _usernameTX.placeholder        = @"用户账号";
    _usernameTX.layer.cornerRadius = 2;
    _usernameTX.layer.borderColor  = UIColorSeparator.CGColor;
    _usernameTX.layer.borderWidth  = PixelOne;
    _usernameTX.textInsets         = UIEdgeInsetsMake(0, 10, 0, 10);
    _usernameTX.clearButtonMode    = UITextFieldViewModeAlways;
    _usernameTX.delegate           = self;
  }
  return _usernameTX;
}

- (QMUITextField *)passwordTX {
  if (!_passwordTX) {
    _passwordTX                    = [QMUITextField new];
    _usernameTX.font               = UIFontMake(16);
    _passwordTX.secureTextEntry    = YES;
    _passwordTX.placeholder        = @"用户密码";
    _passwordTX.layer.cornerRadius = 2;
    _passwordTX.layer.borderColor  = UIColorSeparator.CGColor;
    _passwordTX.layer.borderWidth  = PixelOne;
    _passwordTX.textInsets         = UIEdgeInsetsMake(0, 10, 0, 10);
    _passwordTX.clearButtonMode    = UITextFieldViewModeAlways;
  }
  return _passwordTX;
}

- (QMUIButton *)loginBtn {
  if (!_loginBtn) {
    _loginBtn = [QDUIHelper generateDarkFilledButton];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
  }
  return _loginBtn;
}

- (QMUIButton *)registerBtn {
  if (!_registerBtn) { _registerBtn = [self generateLinkButtonWithTitle:@"账户注册"]; }
  return _registerBtn;
}

- (QMUIButton *)findPasswordBtn {
  if (!_findPasswordBtn) { _findPasswordBtn = [self generateLinkButtonWithTitle:@"找回密码"]; }
  return _findPasswordBtn;
}

- (QMUIButton *)faceBtn {
  if (!_faceBtn) {
    _faceBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
    [_faceBtn setImagePosition:QMUIButtonImagePositionTop];
    [_faceBtn setImage:UIImageMake(@"face_unclicked") forState:UIControlStateNormal];
    [_faceBtn setTitle:@"人脸认证" forState:UIControlStateNormal];
  }
  return _faceBtn;
}

- (QMUILinkButton *)generateLinkButtonWithTitle:(NSString *)title {
  QMUILinkButton *linkButton                    = [[QMUILinkButton alloc] init];
  linkButton.adjustsTitleTintColorAutomatically = YES;
  linkButton.tintColor                          = UIColor.qd_tintColor;
  linkButton.titleLabel.font                    = UIFontMake(15);
  [linkButton setTitle:title forState:UIControlStateNormal];
  [linkButton sizeToFit];
  return linkButton;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.usernameTX) { [self.passwordTX becomeFirstResponder]; }
  return YES;
}
@end
