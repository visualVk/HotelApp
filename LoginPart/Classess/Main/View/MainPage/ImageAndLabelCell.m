//
//  ImageAndLabelCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ImageAndLabelCell.h"
#import "MarkUtils.h"
@interface ImageAndLabelCell () <GenerateEntityDelegate>

@end

@implementation ImageAndLabelCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.clearColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview          = self.contentView;
  self.imageview             = [UIImageView new];
  self.imageview.image       = UIImageMake(@"icon_grid_toast");
  self.imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  self.label                 = [UILabel new];
  self.label.font            = UIFontBoldMake(16);
  self.label.text            = @"all";
  self.label.textColor       = UIColor.qmui_randomColor;
  
  addView(self.contentView, self.imageview);
  addView(self.contentView, self.label);
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview);
    make.centerX.offset(0);
    make.height.greaterThanOrEqualTo(superview.mas_height).multipliedBy(0.4);
    make.bottom.equalTo(self.label).offset(-10);
    make.width.equalTo(self.imageview.mas_height);
  }];
  
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.lessThanOrEqualTo(superview.mas_height).multipliedBy(0.4);
    make.bottom.equalTo(superview.mas_bottom).offset(-5);
    make.centerX.offset(0);
  }];
}

@end
