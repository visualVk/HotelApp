//
//  TYCyclePagerViewCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@implementation TYCyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - generate root view
- (void)generateRootView {
  self.imageview             = [UIImageView new];
  self.imageview.image       = [UIImage new];
  self.imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  [self.contentView addSubview:self.imageview];
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.right.left.equalTo(self.contentView);
//    make.centerX.offset(0);
  }];
}
@end
