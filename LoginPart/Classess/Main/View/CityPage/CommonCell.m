//
//  CommonCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CommonCell.h"
#import "MarkUtils.h"

@interface CommonCell () <GenerateEntityDelegate>

@end

@implementation CommonCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
  UIView *superview = self.contentView;
  addView(superview, self.label);
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).offset(0.5 * SPACE);
    make.left.equalTo(superview).offset(0.5*SPACE);
    make.right.equalTo(superview).offset(-0.5*SPACE);
    make.bottom.equalTo(superview);
    make.width.greaterThanOrEqualTo(@(DEVICE_WIDTH - SPACE - 10));
  }];
  
  self.label.qmui_borderColor    = UIColor.qd_separatorColor;
  self.label.qmui_borderPosition = QMUIViewBorderPositionBottom;
}

- (QMUILabel *)label {
  if (!_label) {
    _label                   = [QMUILabel new];
    _label.font              = UIFontMake(16);
    _label.textColor         = UIColor.qd_mainTextColor;
    _label.text              = @"温州";
    _label.backgroundColor   = UIColor.clearColor;
    _label.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0.5 * SPACE, 0);
  }
  return _label;
}
@end
