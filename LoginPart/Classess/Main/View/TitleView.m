//
//  TitleView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TitleView.h"
#import "MarkUtils.h"
@interface TitleView ()<GenerateEntityDelegate>

@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)generateRootView{
  self.title = [UILabel new];
  self.title.font = UIFontBoldMake(16);
  self.title.text = @"主题";
  self.title.textColor = UIColor.qd_mainTextColor;
  self.moreBtn = [QMUIButton new];
  [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
  [self.moreBtn setImage:@"right_arrow_small" forState:UIControlStateNormal];
  self.moreBtn.imagePosition = QMUIButtonImagePositionRight;
  
  addView(self, self.title);
}
@end
