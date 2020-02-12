//
//  SearchView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "SearchView.h"
@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  UIEdgeInsets padding =
  UIEdgeInsetsConcat(UIEdgeInsetsMake(26, 26, 26, 26), self.qmui_safeAreaInsets);
  CGFloat titleLabelMarginTop = 20;
  self.titleLabel.frame =
  CGRectMake(padding.left, padding.top,
             CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding),
             CGRectGetHeight(self.titleLabel.frame));
  
  CGFloat minY               = CGRectGetMaxY(self.titleLabel.frame) + titleLabelMarginTop;
  self.floatLayoutView.frame = CGRectMake(
                                          padding.left, minY, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding),
                                          CGRectGetHeight(self.bounds) - minY);
}

- (void)generateRootView {
  self.backgroundColor = UIColor.qd_backgroundColor;
  
  self.titleLabel =
  [[QMUILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UIColor.qd_mainTextColor];
  self.titleLabel.text              = @"最近搜索";
  self.titleLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
  [self.titleLabel sizeToFit];
  self.titleLabel.qmui_borderPosition = QMUIViewBorderPositionBottom;
  [self addSubview:self.titleLabel];
  
  self.floatLayoutView                 = [[QMUIFloatLayoutView alloc] init];
  self.floatLayoutView.padding         = UIEdgeInsetsZero;
  self.floatLayoutView.itemMargins     = UIEdgeInsetsMake(0, 0, 10, 10);
  self.floatLayoutView.minimumItemSize = CGSizeMake(69, 29);
  [self addSubview:self.floatLayoutView];
  
  NSArray<NSString *> *suggestions =
  @[ @"Helps", @"Maintain", @"Liver", @"Health", @"Function", @"Supports", @"Healthy", @"Fat" ];
  for (NSInteger i = 0; i < suggestions.count; i++) {
    QMUIGhostButton *button = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
    [button setTitle:suggestions[i] forState:UIControlStateNormal];
    button.titleLabel.font   = UIFontMake(14);
    button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
    [self.floatLayoutView addSubview:button];
  }
}
@end
