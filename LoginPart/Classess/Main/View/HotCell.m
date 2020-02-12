//
//  HotCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotCell.h"
#import "MarkUtils.h"
#pragma mark - hot content cell
@interface HotContentCell : UICollectionViewCell <GenerateEntityDelegate>
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) QMUILabel *placeholder;
@end

@implementation HotContentCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview                   = self.contentView;
  self.imageview                      = [UIImageView new];
  self.imageview.contentMode          = QMUIImageResizingModeScaleAspectFill;
  self.bottomView                     = [UIView new];
  self.bottomView.backgroundColor     = UIColor.qd_backgroundColor;
  self.title                          = [UILabel new];
  self.title.font                     = UIFontBoldMake(TITLEFONTSIZE);
  self.title.text                     = @"温州万达";
  self.title.textColor                = UIColor.qd_mainTextColor;
  self.placeholder                    = [QMUILabel new];
  self.placeholder.contentEdgeInsets  = UIEdgeInsetsMake(-2, 2, 2, -2);
  self.placeholder.font               = UIFontMake(TITLEPLACE);
  self.placeholder.text               = @"舒适的温州";
  self.placeholder.textColor          = UIColor.qd_backgroundColor;
  self.placeholder.backgroundColor    = UIColor.qd_tintColor;
  self.placeholder.layer.cornerRadius = 2;
  
  superview.mas_key = @"superview";
  self.imageview.mas_key = @"imageview";
  addView(superview, self.imageview);
  self.bottomView.mas_key = @"bottomView";
  addView(superview, self.bottomView);
  self.title.mas_key = @"title";
  addView(self.bottomView, self.title);
  self.placeholder.mas_key = @"placeholder";
  addView(self.bottomView, self.placeholder);
  MASAttachKeys(superview);
  
  [self.imageview mas_updateConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(superview);
    make.bottom.equalTo(self.bottomView);
  }];
  
  [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.imageview);
    make.bottom.equalTo(superview);
  }];
  
  [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(self.bottomView).offset(0.5 * SPACE);
    make.right.equalTo(self.bottomView).offset(-0.5 * SPACE);
  }];
  
  [self.placeholder mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.title);
    make.top.greaterThanOrEqualTo(self.title.mas_bottom).offset(0.5 * SPACE);
    make.bottom.equalTo(self.bottomView).offset(-0.5 * SPACE);
  }];
  
  [self.bottomView
   mas_updateConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(superview); }];
}

@end

#pragma mark - hot cell
#import <WSLWaterFlowLayout/WSLWaterFlowLayout.h>
#import "TitleCell.h"
#define HOTCONTENTCELL @"hotecontentcell"
#define TOPTITLECELL @"toptitlecell"
#define FIRSTCELLHEIGHT DEVICE_HEIGHT / 7
#define SECONDCELLHEIGHT DEVICE_HEIGHT / 6
#define THIRDCELLHEIGHT DEVICE_HEIGHT / 5
#define COL 2
#define SEC 2
@interface HotCell () <UICollectionViewDelegate, UICollectionViewDataSource,
WSLWaterFlowLayoutDelegate, GenerateEntityDelegate>
@end

@implementation HotCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  self.datas = @[
    @"icon_moreOperation_shareFriend", @"icon_grid_titleView", @"profile_background",
    @"profile_background", @"profile_background", @"profile_background", @"profile_background",
    @"profile_background", @"profile_background", @"profile_background"
  ];
  [self generateRootView];
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.userInteractionEnabled = false;
  UIView *superview = self.contentView;
  
  addView(self.contentView, self.collectionview);
  
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(superview);
    make.right.equalTo(superview);
    make.height.equalTo(@(DEVICE_HEIGHT));
    make.bottom.equalTo(superview);
  }];
}

- (UICollectionView *)collectionview {
  if (!_collectionview) {
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc] init];
    layout.delegate            = self;
    layout.flowLayoutStyle     = WSLWaterFlowVerticalEqualWidth;
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.scrollEnabled   = YES;
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    _collectionview.delegate        = self;
    _collectionview.dataSource      = self;
    [_collectionview registerClass:[TitleCell class] forCellWithReuseIdentifier:TOPTITLECELL];
    [_collectionview registerClass:[HotContentCell class]
        forCellWithReuseIdentifier:HOTCONTENTCELL];
  }
  return _collectionview;
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 10;
      break;
      
    default:
      break;
  }
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row     = indexPath.row;
  if (section == 0) {
    TitleCell *tCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TOPTITLECELL forIndexPath:indexPath];
    return tCell;
  }
  if (section == 1) {
    HotContentCell *hcCell = [collectionView dequeueReusableCellWithReuseIdentifier:HOTCONTENTCELL
                                                                       forIndexPath:indexPath];
    hcCell.imageview.image = UIImageMake(@"launch_background");
    return hcCell;
  }
  
  return nil;
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
sizeForFooterViewInSection:(NSInteger)section {
  return CGSizeMake(0, 0);
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
sizeForHeaderViewInSection:(NSInteger)section {
  return CGSizeMake(0, 0);
}

- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  NSInteger section = indexPath.section;
  if(section == 0){
    return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT / 20);
  }
  switch (row % 3) {
    case 0:
      return CGSizeMake(20, THIRDCELLHEIGHT);
    case 1:
      return CGSizeMake(20, SECONDCELLHEIGHT);
    case 2:
      return CGSizeMake(20, FIRSTCELLHEIGHT);
  }
  return CGSizeZero;
}

- (CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return 2;
}

- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return UIEdgeInsetsMake(0, 0, 2, 0);
}

- (CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return SPACE;
}

- (CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout {
  return SPACE;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  CGPoint point = scrollView.contentOffset;
  if(point.y <= 0.1){
    self.userInteractionEnabled = false;
    self.scrollview.userInteractionEnabled = true;
  }
}
@end
