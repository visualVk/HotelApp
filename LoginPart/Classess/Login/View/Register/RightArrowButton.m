//
//  RightArrowButton.m
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RightArrowButton.h"

@implementation RightArrowButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.offset(-5);
    make.top.bottom.offset(0);
    make.width.equalTo(self.imageView.mas_height);
  }];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(10);
    make.top.bottom.offset(0);
    make.trailing.equalTo(self.imageView.mas_leading);
  }];
}

@end
