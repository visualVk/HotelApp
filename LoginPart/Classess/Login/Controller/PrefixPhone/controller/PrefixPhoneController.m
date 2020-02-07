//
//  PrefixPhoneController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "PrefixPhoneController.h"
#define PHONECELL @"PhoneCell"
@interface PrefixPhoneController ()

@end

@implementation PrefixPhoneController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
}

- (void)initTableView {
  [super initTableView];
  // 对 self.tableView 的操作写在这里
  //  [self.tableView registerClass:[QMUITableViewCell class] forCellReuseIdentifier:PHONECELL];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
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
  self.title = @"区号选择";
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return arc4random() % 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 15;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSString *title = nil;
  for (int i = 0; i < 15; ++i) {
    if (section == i) { title = [NSString stringWithFormat:@"section :%d", i]; }
  }
  return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PHONECELL];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView
                                             withStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:PHONECELL];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.section * 15 + indexPath.row];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"+%u", arc4random() % 100];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"phone table view", @"select section: %li, row: %li", indexPath.section,
              indexPath.row);
  QMUITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  ;
  NSString *textContent = cell.detailTextLabel.text;
  self.SelectedBlock(textContent);
}
@end
