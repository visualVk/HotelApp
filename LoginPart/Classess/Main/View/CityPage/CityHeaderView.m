//
//  CityHeaderView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CityHeaderView.h"
#import "MarkUtils.h"

@interface CityHeaderView () <GenerateEntityDelegate>

@end

@implementation CityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { self.backgroundColor = UIColor.qd_backgroundColor; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - GenerateEntityDelegate
- (void)generateRootView {
}

#pragma mark - Lazy init Title Label
- (UILabel *)title {
  if (!_title) {
    _title               = [UILabel new];
    _title.text          = @"title";
    _title.font          = UIFontBoldMake(18);
    _title.textColor     = UIColor.qd_mainTextColor;
    _title.textAlignment = NSTextAlignmentLeft;
    addView(self, _title);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self).offset(SPACE);
      make.right.equalTo(self).offset(-SPACE);
      make.top.bottom.equalTo(self);
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
  }
  return _title;
}

- (void)loadData {
  [self setNeedsLayout];
  [self layoutIfNeeded];
}
@end
