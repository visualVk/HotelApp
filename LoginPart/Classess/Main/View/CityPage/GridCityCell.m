//
//  GridCityCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "GridCityCell.h"
#import "MarkUtils.h"
@interface GridCityCell () <GenerateEntityDelegate>

@end

@implementation GridCityCell

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
  addView(superview, self.labelBtn);
  [self.labelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(superview);
    make.width.equalTo(@((DEVICE_WIDTH - 4 * SPACE) / 3));
    make.top.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(superview).offset(-0.5*SPACE);
  }];
}

#pragma mark - Lazy init Lable Button
- (QMUILabel *)labelBtn {
  if (!_labelBtn) {
    _labelBtn                     = [QMUILabel new];
    _labelBtn.textColor           = UIColor.qd_mainTextColor;
    _labelBtn.font                = UIFontMake(18);
    _labelBtn.textAlignment       = NSTextAlignmentCenter;
    _labelBtn.contentEdgeInsets   = UIEdgeInsetsMake(10, 10, 10, 10);
    _labelBtn.backgroundColor     = UIColor.qd_separatorColor;
    _labelBtn.layer.cornerRadius  = 5;
    _labelBtn.layer.masksToBounds = YES;
    //    [self.contentView setNeedsLayout];
    //    [self.contentView layoutIfNeeded];
  }
  return _labelBtn;
}

- (void)loadData {
  [self setNeedsLayout];
  [self layoutIfNeeded];
}
@end
