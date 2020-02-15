//
//  ImageReFreshHeader.m
//  LoginPart
//
//  Created by blacksky on 2020/2/8.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ImageReFreshHeader.h"
@interface ImageReFreshHeader ()
@property (weak, nonatomic) UIImageView *gifView;
@end

@implementation ImageReFreshHeader

#pragma mark - 加载GIF
- (NSArray *)loadImageWithNameFormat:(NSString *)imagePrefix Total:(NSInteger)total {
  NSString *imageName = nil;
  UIImage *image      = nil;
  NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:total];
  for (int i = 0; i < total; ++i) {
    imageName = [NSString stringWithFormat:imagePrefix, i];
    [arr addObject:[UIImage imageNamed:imageName]];
  }
  return arr;
}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
  [super prepare];
  
  // 设置控件的高度
  self.mj_h = 80;
  
  // 打酱油的开关
  
  // logo
  self.gifView                      = [UIImageView new];
  self.gifView.contentMode          = QMUIImageResizingModeScaleAspectFill;
  self.gifView.animationImages      = [self loadImageWithNameFormat:@"loading_image_%i" Total:62];
  self.gifView.animationDuration    = 5;
  self.gifView.animationRepeatCount = 0;
  //  [self.gifView startAnimating];
  [self addSubview:self.gifView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
  [super placeSubviews];
  
  //  self.label.frame = self.bounds;
  
  //  self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
  //  self.logo.center = CGPointMake(self.mj_w * 0.5, -self.logo.mj_h + 20);
  //
  //  self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
  //  self.gifView.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
  //  self.gifView.center = CGPointMake(self.mj_w * 0.5, - self.gifView.mj_h + 20);
  @weakify(self);
  [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
    @strongify(self);
    make.left.right.top.bottom.equalTo(self);
  }];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
  [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
  [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
  [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
  MJRefreshCheckState;
  
  switch (state) {
    case MJRefreshStateIdle:
      //      [self.loading stopAnimating];
      //      [self.s setOn:NO animated:YES];
      //      self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
      [self.gifView stopAnimating];
      break;
    case MJRefreshStatePulling:
      //      [self.loading stopAnimating];
      //      [self.s setOn:YES animated:YES];
      //      self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
      [self.gifView stopAnimating];
      break;
    case MJRefreshStateRefreshing:
      //      [self.s setOn:YES animated:YES];
      //      self.label.text = @"加载数据中(开关是打酱油滴)";
      //      [self.loading startAnimating];
      [self.gifView startAnimating];
      break;
    default:
      [self.gifView startAnimating];
      break;
  }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
  [super setPullingPercent:pullingPercent];
  
  // 1.0 0.5 0.0
  // 0.5 0.0 0.5
  //  CGFloat red          = 1.0 - pullingPercent * 0.5;
  //  CGFloat green        = 0.5 - 0.5 * pullingPercent;
  //  CGFloat blue         = 0.5 * pullingPercent;
  //  self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
