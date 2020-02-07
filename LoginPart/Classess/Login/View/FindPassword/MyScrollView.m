//
//  MyScrollView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {}
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
  return NO;
}
@end
