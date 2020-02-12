//
//  TitleView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TitleCell.h"
#import "MarkUtils.h"
@interface TitleCell () <GenerateEntityDelegate>

@end

@implementation TitleCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.title           = [UILabel new];
  self.title.font      = UIFontBoldMake(TITLEFONTSIZE);
  self.title.text      = @"主题";
  self.title.textColor = UIColor.qd_mainTextColor;
  self.moreBtn         = [QMUIButton new];
  [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
  self.moreBtn.titleLabel.font = UIFontMake(TITLELITE);
  [self.moreBtn setTitleColor:UIColor.qd_placeholderColor forState:UIControlStateNormal];
  [self.moreBtn setImage:UIImageMake(@"right_arrow_small") forState:UIControlStateNormal];
  self.moreBtn.imagePosition = QMUIButtonImagePositionRight;
  
  addView(self.contentView, self.title);
  addView(self.contentView, self.moreBtn);
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.contentView).offset(0.5 * SPACE);
    make.bottom.lessThanOrEqualTo(self.contentView).offset(-0.5 * SPACE);
  }];
  
  [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.contentView).offset(-0.5 * SPACE);
    make.centerY.equalTo(self.title);
  }];
}
@end
