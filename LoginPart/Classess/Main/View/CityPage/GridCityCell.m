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
  UIView *superview    = self.contentView;
  UIView *view         = [UIView new];
  view.backgroundColor = UIColor.qmui_randomColor;
  view.frame           = CGRectMake(0, 0, 100, 100);
  addView(superview, view);
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.bottom.equalTo(superview);
  }];
}
@end
