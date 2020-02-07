//
//  ProfileController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ProfileController.h"
#import "IDAuthViewController.h"
#import "IDInfo.h"
#import "LogoImageCell.h"
#import "LogoView.h"
#import "NSObject+BlockSEL.h"
#import "TextFieldAndButtonCell.h"
#import "TextFieldCell.h"
#define CELLONE @"cellone"
#define CELLTWO @"celltwo"
#define Height 1.0 / 10;
#define HeaderHeight [UIScreen mainScreen].bounds.size.height / 15.0;
#define EMHeight [UIScreen mainScreen].bounds.size.height / 10.0
#define CellHeight [UIScreen mainScreen].bounds.size.height / 20.0
typedef void (^BindBlock)(NSString *x);
@interface ProfileController () <QMUITextFieldDelegate> {
  NSArray *_profileArray;
  NSArray *_accountArray;
  NSInteger tagIndex;
  NSString *successMsg;
}
@property (nonatomic, strong) IDInfo *idInfo;
@end

@implementation ProfileController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  _profileArray = @[ @"名字", @"性别", @"身份证" ];
  _accountArray = @[ @"昵称", @"密码", @"确认密码" ];
  tagIndex      = 0;
  self.users    = [Users new];
  self.idInfo   = [IDInfo new];
}

- (void)initTableView {
  [super initTableView];
  // 对 self.tableView 的操作写在这里
  //  self.tableView.rowHeight      = UITableViewAutomaticDimension;
  self.tableView.separatorColor = [UIColor clearColor];
  //  self.tableView.backgroundView =
  //  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_background"]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  @weakify(self);
  [RACObserve(self.idInfo, name) subscribeNext:^(NSString *x) {
    @strongify(self);
    self.users.name = x;
  }];
  [RACObserve(self.idInfo, num) subscribeNext:^(NSString *x) {
    @strongify(self);
    self.users.idCard = x;
  }];
  [RACObserve(self.idInfo, gender) subscribeNext:^(NSString *x) {
    @strongify(self);
    self.users.gender = x;
  }];
  if (self.idInfo) {
    QMUILogInfo(@"id info", @"id info:{%@}", [DictUtils Object2Dict:self.idInfo]);
  }
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
  self.title = @"账户注册 3/3";
}

#pragma mark - 生成布局
- (void)generateRootView {
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 4;
    case 2:
      return 5;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  __weak __typeof(self) weakSelf = self;
  if (indexPath.section == 0) {  // section 0
    LogoImageCell *cell = [[LogoImageCell alloc] initForTableView:tableView
                                                        withStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:@"cell1"];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
  } else if (indexPath.section == 1) {  // section 1
    if (indexPath.row > 2) {
      QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Label"];
      if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                                 withStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:@"Label"];
      }
      cell.textLabel.text       = @"注意事项";
      cell.detailTextLabel.text = @"自动获取功为本地功能，无需担心信息泄漏";
      return cell;
    }
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLONE];
    if (!cell) {
      cell = [[TextFieldCell alloc] initForTableView:tableView
                                           withStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CELLONE];
    }
    cell.textField.placeholder = _profileArray[indexPath.row];
    cell.textField.delegate    = self;
    cell.textField.tag         = (indexPath.section - 1) * _profileArray.count + indexPath.row;
    cell.textField.qmui_keyboardWillShowNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf showKeyBoard:keyboardUserInfo]; };
    cell.textField.qmui_keyboardWillHideNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf hideKeyBoard:keyboardUserInfo]; };
    if (indexPath.row == 0) {
      RACChannelTo(self.users, name) = cell.textField.rac_newTextChannel;
    } else if (indexPath.row == 1) {
      RACChannelTo(self.users, gender) = cell.textField.rac_newTextChannel;
    } else if (indexPath.row == 2) {
      cell.textField.maximumTextLength = 18;
      RACChannelTo(self.users, idCard) = cell.textField.rac_newTextChannel;
    }
    return cell;
  } else if (indexPath.section == 2) {  // section 2
    //    if (indexPath.row > 2) return [QMUITableViewCell new];
    if (indexPath.row == 3) {
      QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Label"];
      if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                                 withStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:@"Label"];
      }
      [self comparePassword:cell];
      return cell;
    }
    if (indexPath.row == 4) {
      QMUITableViewCell *cell = [QMUITableViewCell new];
      QMUIButton *btn         = [QDUIHelper generateDarkFilledButton];
      [btn setTitle:@"注册并登陆" forState:UIControlStateNormal];
      [btn addTarget:self
              action:[self selectorBlock:^(id _Nonnull args) {
        QMUILogInfo(@"users", @"users:{%@}", [DictUtils Object2Dict:weakSelf.users]);
        [weakSelf postProfileAndAccountMsg];
      }]
    forControlEvents:UIControlEventTouchUpInside];
      [cell addSubview:btn];
      [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top).offset(5);
        make.right.equalTo(cell.mas_right).offset(-10);
        make.left.equalTo(cell.mas_left).offset(10);
        make.bottom.equalTo(cell.mas_bottom);
      }];
      return cell;
    }
    TextFieldAndButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLTWO];
    if (!cell) {
      cell = [[TextFieldAndButtonCell alloc] initForTableView:tableView
                                                    withStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:CELLTWO];
    }
    NSString *placeholder = _accountArray[indexPath.row];
    if ([placeholder containsString:@"密码"]) { cell.textField.secureTextEntry = YES; }
    cell.textField.placeholder = placeholder;
    cell.textField.delegate    = self;
    cell.textField.tag         = (indexPath.section - 1) * _profileArray.count + indexPath.row;
    cell.textField.qmui_keyboardWillShowNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf showKeyBoard:keyboardUserInfo]; };
    cell.textField.qmui_keyboardWillHideNotificationBlock =
    ^(QMUIKeyboardUserInfo *keyboardUserInfo) { [weakSelf hideKeyBoard:keyboardUserInfo]; };
    if (indexPath.row == 1) {
      [self bindPassword:cell bindBlock:^(NSString *x) { self.users.password = x; }];
    } else if (indexPath.row == 2) {
      [self bindPassword:cell bindBlock:^(NSString *x) { self.users.passwordTwo = x; }];
    }
    return cell;
  }
  QMUITableViewCell *cell = [QMUITableViewCell new];
  cell.selectionStyle     = UITableViewCellSelectionStyleNone;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView qmui_clearsSelection];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  QMUITableViewHeaderFooterView *headerView =
  (QMUITableViewHeaderFooterView *)[super tableView:tableView viewForHeaderInSection:section];
  //  headerView.backgroundView = [UIImageView new];
  headerView.qmui_borderColor    = UIColor.qd_separatorColor;
  headerView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
  headerView.backgroundView.backgroundColor = UIColorMakeWithHex(@"#F2F6FC");
  if (section == 1) {
    QMUIButton *button = (QMUIButton *)headerView.accessoryView;
    if (!button) {
      button = [QMUIButton new];
      [button setTitle:@"自动提取" forState:UIControlStateNormal];
      button.qmui_automaticallyAdjustTouchHighlightedInScrollView = YES;
      headerView.accessoryView                                    = button;
      button.titleLabel.font                                      = UIFontMake(14);
      button.imagePosition                                        = QMUIButtonImagePositionLeft;
      [button setImage:[UIImage imageNamed:@"scan_small"] forState:UIControlStateNormal];
      [button sizeToFit];
      __weak __typeof(self) weakSelf = self;
      [button addTarget:self
                 action:[self selectorBlock:^(id _Nonnull args) {
        IDAuthViewController *idaController = [IDAuthViewController new];
        idaController.IDCardBlock = ^(IDInfo *idInfo) { weakSelf.idInfo = idInfo; };
        [weakSelf.navigationController pushViewController:idaController animated:YES];
      }]
       forControlEvents:UIControlEventTouchUpInside];
    }
  }
  return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 1) {
    return @"个人信息部分";
  } else if (section == 2) {
    return @"账号部分";
  }
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return EMHeight;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
  return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0 && indexPath.row == 0) {
    return UITableViewAutomaticDimension;
  } else if (indexPath.section == 2 && indexPath.row == 4)
    return CellHeight;
  return EMHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) { return 0.1; }
  return HeaderHeight;
}

#pragma mark - 键盘显示，table view content view的偏移
- (void)showKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf = self;
  CGRect keyBoardRect = [userInfo.originUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}

- (void)hideKeyBoard:(QMUIKeyboardUserInfo *)userInfo {
  __weak __typeof(self) weakSelf  = self;
  weakSelf.tableView.contentInset = UIEdgeInsetsZero;
}
#pragma mark - text field代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  NSInteger nextTag        = textField.tag + 1;
  NSIndexPath *indexPath   = [NSIndexPath indexPathForItem:0 inSection:1];
  QMUITableViewCell *cell  = nil;
  QMUITextField *nextField = nil;
  while (!nextField) {
    if (indexPath.section == 1) {
      if (indexPath.row < _profileArray.count) {
        indexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
      } else {
        indexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.section + 1];
      }
    } else if (indexPath.section == 2) {
      if (indexPath.row < _accountArray.count) {
        indexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
      } else {
        return NO;
      }
    }
    cell      = [self.tableView cellForRowAtIndexPath:indexPath];
    nextField = [cell viewWithTag:nextTag];
  }
  [textField resignFirstResponder];
  [nextField becomeFirstResponder];
  return YES;
}

#pragma mark - 密码对比Label
- (void)comparePassword:(QMUITableViewCell *)cell {
  @weakify(self);
  [[[[RACSignal
      combineLatest:@[ RACObserve(self.users, password), RACObserve(self.users, passwordTwo) ]]
     map:^id _Nullable(RACTuple *tuple) {
    return @([self.users.password isEqualToString:self.users.passwordTwo]);
  }] distinctUntilChanged] subscribeNext:^(NSNumber *x) {
    //    @strongify(self);
    if (x.boolValue) {
      QMUILogInfo(@"same", @"result:yes");
      cell.textLabel.text = @"yes";
    } else {
      QMUILogInfo(@"same", @"result:false");
      cell.textLabel.text       = @"false";
      cell.detailTextLabel.text = @"password should include xxxx";
    }
  }];
}
#pragma mark - rac绑定
- (void)bindPassword:(TextFieldAndButtonCell *)cell bindBlock:(BindBlock)bindBlock {
  @weakify(self);
  [[cell.textField.rac_textSignal takeUntil:cell.rac_prepareForReuseSignal]
   subscribeNext:^(NSString *_Nullable x) {
    @strongify(self);
    bindBlock(x);
  }];
  //  [[RACObserve(cell.textField, text) takeUntil:cell.rac_prepareForReuseSignal]
  //   subscribeNext:^(NSString *_Nullable x) {
  //    @strongify(self);
  //    bindBlock(x);
  //  }];
}
- (void)bindProperty:(id)object bindBlock:(BindBlock)bindBlock {
}

- (void)postProfileAndAccountMsg {
  [[RequestUtils shareManager] RequestPostWithUrl:@"findUser"
                                           Object:self.users
                                          Success:^(NSDictionary *_Nullable dict) { QMUILogInfo(@"success", @"success"); }
                                          Failure:^(NSError *_Nullable err) { QMUILogWarn(@"warn", @"failed"); }];
}
@end
