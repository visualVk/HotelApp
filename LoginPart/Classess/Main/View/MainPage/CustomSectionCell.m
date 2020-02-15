//
//  CustomSectionCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CustomSectionCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"

/// Round Card Cell
@interface RoundCardCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *label;
@end

@implementation RoundCardCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.layer.shadowColor   = UIColor.qd_mainTextColor.CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 1);
    self.layer.shadowRadius  = 2;
    self.layer.shadowOpacity = 0.25;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview              = self.contentView;
  UIView *container              = [UIView new];
  self.imageview                 = [UIImageView new];
  self.imageview.backgroundColor = UIColor.qmui_randomColor;
  self.imageview.image           = UIImageMake(@"right_arrow_small");
  self.imageview.contentMode     = QMUIImageResizingModeScaleAspectFill;
  self.label                     = [UILabel new];
  self.label.backgroundColor     = UIColor.qd_backgroundColor;
  self.label.text                = @"label";
  self.label.textAlignment       = NSTextAlignmentCenter;
  self.label.font                = UIFontBoldMake(16);
  
  addView(self.contentView, container);
  addView(container, self.imageview);
  addView(container, self.label);
  
  [container mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  
  [self.imageview mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(container);
    make.height.equalTo(container.mas_width).multipliedBy(0.7);
  }];
  
  [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.imageview.mas_bottom);
    make.bottom.equalTo(container);
    make.centerX.offset(0);
    make.left.right.equalTo(self.imageview);
  }];
  
  [self layoutIfNeeded];
  
  container.layer.cornerRadius  = DEVICE_HEIGHT / 100;
  container.layer.masksToBounds = true;
  container.clipsToBounds       = true;
}

@end

@interface CustomSectionCell () <GenerateEntityDelegate, UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) MASConstraint *cF;
@end

@implementation CustomSectionCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - generate root view
- (void)generateRootView {
  // top bar view
  self.backgroundColor = UIColor.clearColor;
  UIView *topBarView   = [UIView new];
  UIView *superview    = self.contentView;
  self.selectionStyle  = UITableViewCellSelectionStyleNone;
  self.leftLabel       = [UILabel new];
  self.leftLabel.font  = UIFontBoldMake(16);
  self.leftLabel.text  = @"left";
  
  addView(self.contentView, topBarView);
  addView(topBarView, self.leftLabel);
  addView(topBarView, self.imageview);
  addView(topBarView, self.rightLabel);
  
  [topBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.left.mas_equalTo(superview).offset(SPACE);
    make.height.greaterThanOrEqualTo(@1);
    make.right.equalTo(superview).offset(-SPACE);
  }];
  
  [self.leftLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.imageview);
    make.left.equalTo(topBarView.mas_left);
  }];
  
  [self.imageview mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.right.equalTo(topBarView);
    //    make.height.greaterThanOrEqualTo(@1);
    make.bottom.equalTo(topBarView).offset(-5);
  }];
  
  [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.imageview.mas_left);
    make.centerY.equalTo(self.imageview);
  }];
  
  topBarView.qmui_borderColor    = UIColor.qd_separatorColor;
  topBarView.qmui_borderPosition = QMUIViewBorderPositionBottom;
  
  //  // collection view
  UIView *bottomBarView                  = [UIView new];
  bottomBarView.backgroundColor          = UIColor.qmui_randomColor;
  QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                            initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
  layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  layout.itemSize = CGSizeMake((CGRectGetWidth(UIScreen.mainScreen.bounds) - SPACE * 2) / 2 * 0.8,
                               (CGRectGetWidth(UIScreen.mainScreen.bounds) - SPACE * 2) / 2 * 0.8);
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing      = (DEVICE_WIDTH - SPACE * 2) * 0.2;
  layout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0);
  self.collectionview =
  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionview.layer.cornerRadius  = CGRectGetWidth(superview.bounds) / 5;
  self.collectionview.backgroundColor     = UIColor.clearColor;
  self.collectionview.clipsToBounds       = false;
  self.collectionview.layer.masksToBounds = false;
  [self.collectionview registerClass:[RoundCardCell class]
          forCellWithReuseIdentifier:@"roundcardcell"];
  self.collectionview.delegate   = self;
  self.collectionview.dataSource = self;
  
  addView(self.contentView, self.collectionview);
  
  [self.collectionview mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(topBarView).offset(DEVICE_WIDTH * 0.1);
    make.centerX.offset(0);
    make.left.mas_equalTo(self.contentView).offset(SPACE);
    make.right.mas_equalTo(self.contentView).offset(-SPACE);
    make.height.greaterThanOrEqualTo(@((DEVICE_WIDTH - SPACE * 2) * .4 + SPACE));
    make.bottom.equalTo(self.contentView);
    make.centerX.mas_equalTo(self.contentView);
  }];
}

- (UIImageView *)imageview {
  if (!_imageview) {
    _imageview             = [UIImageView new];
    _imageview.image       = UIImageMake(@"right_arrow_small");
    _imageview.contentMode = QMUIImageResizingModeScaleAspectFill;
  }
  return _imageview;
}

- (QMUIButton *)rightLabel {
  if (!_rightLabel) {
    _rightLabel = [QMUIButton new];
    [_rightLabel setTitle:@"更多" forState:UIControlStateNormal];
    _rightLabel.titleLabel.font = UIFontMake(16);
    [_rightLabel addTarget:self
                    action:[self selectorBlock:^(id _Nonnull args) { NSLog(@"click!!!"); }]
          forControlEvents:UIControlEventTouchUpInside];
  }
  return _rightLabel;
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  RoundCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"roundcardcell"
                                                                  forIndexPath:indexPath];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"round collection", @"click(section:%li,row:%li)", indexPath.section, indexPath.row);
}
@end
