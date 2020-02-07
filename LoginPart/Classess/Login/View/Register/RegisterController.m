//
//  RegisterController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RegisterController.h"
#import "LogoView.h"
#import "NSObject+BlockSEL.h"
#import "PhoneVertifyController.h"
#import "PrefixPhoneController.h"
#import "ProtocalController.h"
#import "RightArrowButton.h"
#define addSubView(subView) [self.view addSubview:subView]
#define Height 1.0 / 30

@interface RegisterController ()
@property (nonatomic, strong) QMUIButton *prefixPhoneNumBtn;
@property (nonatomic, strong) QMUITextField *phoneNumTX;
@property (nonatomic, strong) QMUIButton *vertifyBtn;
@property (nonatomic, strong) QMUILinkButton *protocolBtn;
//@property(nonatomic, strong) RightArrowButton *prefixPhoneNumBtn;
@end

@implementation RegisterController

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
  self.title = @"账户注册 1/3";
}

#pragma mark - 监听事件
- (void)initListener {
  __weak __typeof(self) weakSelf = self;
  // prefixPhonenum button
  [self.prefixPhoneNumBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    PrefixPhoneController *ppController = [PrefixPhoneController new];
    __weak __typeof(PrefixPhoneController *) weakppController = ppController;
    ppController.SelectedBlock = ^(NSString *textContent) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.prefixPhoneNumBtn
         setTitle:[NSString stringWithFormat:@"国区号 %@", textContent]
         forState:UIControlStateNormal];
      });
      QMUILogInfo(@"prefix phone num", @"change to: %@", textContent);
      [weakppController.navigationController popViewControllerAnimated:YES];
    };
    [weakSelf.navigationController pushViewController:ppController animated:YES];
  }]
   forControlEvents:UIControlEventTouchUpInside];
  // protocal button
  [self.protocolBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    ProtocalController *pController = [ProtocalController new];
    [weakSelf.navigationController pushViewController:pController animated:YES];
  }]
   forControlEvents:UIControlEventTouchUpInside];
  
  // vertify button
  [self.vertifyBtn
   addTarget:self
   action:[self selectorBlock:^(id _Nonnull args) {
    if ([@"" isEqualToString:weakSelf.phoneNumTX.text] || !weakSelf.phoneNumTX.text) {
      [QMUITips showWithText:@"请输入手机号" inView:weakSelf.view hideAfterDelay:2];
    } else {
      /// todo
      PhoneVertifyController *pvController = [PhoneVertifyController new];
      [weakSelf.navigationController qmui_pushViewController:pvController
                                                    animated:YES
                                                  completion:^{
        pvController.phoneNum =
        weakSelf.phoneNumTX.text;
      }];
    }
  }]
   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 生成布局
- (void)generateRootView {
  LogoView *logoView = [LogoView new];
  addSubView(logoView);
  addSubView(self.prefixPhoneNumBtn);
  addSubView(self.phoneNumTX);
  addSubView(self.vertifyBtn);
  addSubView(self.protocolBtn);
  
  UIView *superview = self.view;
  
  [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_safeAreaLayoutGuideTop).offset(30);
    make.centerX.offset(0);
  }];
  [self.prefixPhoneNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(logoView.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.phoneNumTX mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(10);
    make.right.offset(-10);
    make.top.equalTo(self.prefixPhoneNumBtn.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.vertifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(10);
    make.right.offset(-10);
    make.top.equalTo(self.phoneNumTX.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
  }];
  [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.vertifyBtn.mas_bottom).offset(10);
    make.height.equalTo(superview.mas_height).multipliedBy(Height);
    make.centerX.offset(0);
  }];
  
  // 设置成文字图片左右分布，分别左右对齐,edge为原来位置的偏移量，left向右为正,right反之，top向下为正,bottom反之
  self.prefixPhoneNumBtn.titleEdgeInsets =
  UIEdgeInsetsMake(0, -self.prefixPhoneNumBtn.currentImage.size.width + 10, 0,
                   self.prefixPhoneNumBtn.currentImage.size.width - 10);
  self.prefixPhoneNumBtn.imageEdgeInsets = UIEdgeInsetsMake(
                                                            0, superview.frame.size.width - 20 - self.prefixPhoneNumBtn.currentImage.size.width, 0,
                                                            20 + self.prefixPhoneNumBtn.currentImage.size.width - superview.frame.size.width);
  [self.prefixPhoneNumBtn layoutIfNeeded];
}
#pragma mark - 懒加载
- (QMUIButton *)prefixPhoneNumBtn {
  if (!_prefixPhoneNumBtn) {
    _prefixPhoneNumBtn = [QMUIButton buttonWithType:UIButtonTypeSystem];
    [_prefixPhoneNumBtn setTitle:@"国区号 +86" forState:UIControlStateNormal];
    _prefixPhoneNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_prefixPhoneNumBtn setImage:[UIImage imageNamed:@"right_arrow_small"]
                        forState:UIControlStateNormal];
    _prefixPhoneNumBtn.titleLabel.font    = UIFontMake(16);
    _prefixPhoneNumBtn.layer.cornerRadius = 2;
    _prefixPhoneNumBtn.layer.borderColor  = UIColorSeparator.CGColor;
    _prefixPhoneNumBtn.layer.borderWidth  = PixelOne;
    _prefixPhoneNumBtn.tintColor          = UIColor.qd_mainTextColor;
    [_prefixPhoneNumBtn setTitleColor:UIColor.qd_mainTextColor forState:normal];
  }
  return _prefixPhoneNumBtn;
}

- (QMUITextField *)phoneNumTX {
  if (!_phoneNumTX) {
    _phoneNumTX                    = [QMUITextField new];
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

- (QMUIButton *)vertifyBtn {
  if (!_vertifyBtn) {
    _vertifyBtn                 = [QDUIHelper generateDarkFilledButton];
    _vertifyBtn.titleLabel.font = UIFontMake(16);
    [_vertifyBtn setTitle:@"验证手机号" forState:UIControlStateNormal];
  }
  return _vertifyBtn;
}
- (QMUILinkButton *)protocolBtn {
  if (!_protocolBtn) {
    _protocolBtn = [self
                    generateLinkButtonWithTitle:@"我"
                    @"已阅读协议《XXX使用手册》，并同意该协议"];
  }
  return _protocolBtn;
}

- (QMUILinkButton *)generateLinkButtonWithTitle:(NSString *)title {
  QMUILinkButton *linkButton                    = [[QMUILinkButton alloc] init];
  linkButton.adjustsTitleTintColorAutomatically = YES;
  linkButton.tintColor                          = UIColor.qd_placeholderColor;
  linkButton.titleLabel.font                    = UIFontMake(15);
  [linkButton setTitle:title forState:UIControlStateNormal];
  [linkButton sizeToFit];
  return linkButton;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
  return YES;
}
@end
