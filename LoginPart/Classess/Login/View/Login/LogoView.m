//
//  LogoView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) { [self generateRootView]; }
  return self;
}

- (void)generateRootView {
  UIImageView *imageView = [UIImageView new];
  UILabel *label         = [UILabel new];
  self.imageView         = imageView;
  self.label             = label;
  imageView.image        = UIImageMake(@"login_logo");
  label.text             = @"让旅行变得简单";
  label.font             = UIFontMake(28);
  
  [self addSubview:imageView];
  [self addSubview:label];
  
  [imageView
   mas_makeConstraints:^(MASConstraintMaker *make) { make.left.right.top.bottom.offset(0); }];
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.offset(0);
    make.bottom.offset(-15);
  }];
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
