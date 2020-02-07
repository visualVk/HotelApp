//
//  LogoImageCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/5.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LogoImageCell.h"

@implementation LogoImageCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.logoView            = [LogoView new];
  self.logoView.label.text = @"填写用户信息";
  [self.contentView addSubview:self.logoView];
  [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.offset(0);
    make.top.offset(30);
    make.bottom.offset(-20);
  }];
  self.qmui_borderPosition = QMUIViewBorderPositionNone;
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
