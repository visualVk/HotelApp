//
//  SelectionCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "SelectionCell.h"
#import "MarkUtils.h"
#import "TitleCell.h"
#pragma mark - selection content cell
@interface SelectionContentCell : UICollectionViewCell <GenerateEntityDelegate>
@property (nonatomic, strong) UILabel *cellTitle;
@property (nonatomic, strong) UILabel *cellPlaceholder;
@property (nonatomic, strong) UILabel *clickLB;
@property (nonatomic, strong) UIImageView *imageview;
@end

@implementation SelectionContentCell
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview                = self.contentView;
  CGFloat imageHeight = CGRectGetHeight(superview.bounds)*0.7;
  CGFloat textWidth = CGRectGetWidth(superview.bounds) * 0.35;
//  QMUILogInfo(@"selection content cell",frameAndBounds(superview));
  self.cellTitle                   = [UILabel new];
  self.cellTitle.font              = UIFontBoldMake(TITLEPLACE);
  self.cellTitle.text              = @"title";
  self.cellTitle.textColor         = UIColor.qd_mainTextColor;
  self.cellPlaceholder             = [UILabel new];
  self.cellPlaceholder.font        = UIFontMake(TITLEPLACE);
  self.cellPlaceholder.text        = @"placeholder";
  self.cellPlaceholder.textColor   = UIColor.qd_placeholderColor;
  self.clickLB                     = [UILabel new];
  self.clickLB.font                = UIFontMake(13);
  self.clickLB.textAlignment = NSTextAlignmentCenter;
  self.clickLB.text                = @"立即领取";
  self.clickLB.textColor           = UIColor.qd_backgroundColor;
  self.clickLB.backgroundColor     = UIColor.orangeColor;
  self.clickLB.layer.cornerRadius  = 8;
  self.clickLB.layer.masksToBounds = true;
  self.imageview                   = [UIImageView new];
  self.imageview.image             = UIImageMake(@"profile_background");
  self.imageview.contentMode       = QMUIImageResizingModeScaleAspectFill;

    addView(superview, self.imageview);
  addView(superview, self.cellTitle);
  addView(superview, self.cellPlaceholder);
  addView(superview, self.clickLB);
  
  [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(superview).offset(0.5 * SPACE);
    make.bottom.equalTo(self.cellPlaceholder.mas_top);
  }];
  
  [self.cellPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.top.equalTo(self.cellTitle.mas_bottom);
    make.left.equalTo(self.cellTitle).with.priorityHigh;
    make.centerY.equalTo(superview).with.priorityHigh;;
  }];
  
  [self.clickLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.cellPlaceholder.mas_bottom);
    make.left.equalTo(self.cellPlaceholder);
    make.width.greaterThanOrEqualTo(@(textWidth));
  }];
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(superview);
    make.right.equalTo(superview).offset(-0.5*SPACE);
    make.width.equalTo(@(imageHeight));
    make.height.equalTo(@(imageHeight));
  }];
}

@end

#pragma mark - selection cell
#import <JQCollectionViewAlignLayout/JQCollectionViewAlignLayout.h>
#define SELECTCONTENTCELL @"selectioncontentcell"
#define TOPTITLECELL @"toptitlecell"
#define FIRSTROW 1
#define SECONDROW 1
#define FIRSTNUM 2
#define SECONDNUM 1
#define COLLECTIONHEIGHT SECONDTYPESECTIONHEIGHT*FIRSTROW + FIRSTTYPESECTIONHEIGHT*SECONDROW + 2 * (FIRSTROW + SECONDROW - 1)
#define FIRSTTYPESECTIONWIDTH (DEVICE_WIDTH - 2 * SPACE - 2.0 * (FIRSTNUM - 1) - 4) / FIRSTNUM
#define FIRSTTYPESECTIONHEIGHT (DEVICE_WIDTH - 2 * SPACE - 2.0 * (FIRSTNUM - 1)) / (2 * FIRSTNUM)
#define SECONDTYPESECTIONWIDTH (DEVICE_WIDTH - 2 * SPACE - 2.0 * (SECONDNUM - 1)) / SECONDNUM
#define SECONDTYPESECTIONHEIGHT DEVICE_HEIGHT / 20
@interface SelectionCell () <GenerateEntityDelegate, UICollectionViewDataSource,
UICollectionViewDelegate, JQCollectionViewAlignLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionview;
@end

@implementation SelectionCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
  QMUILogInfo(@"first section frame", @"%f,%f", FIRSTTYPESECTIONHEIGHT, FIRSTTYPESECTIONWIDTH);
  self.selectionStyle     = UITableViewCellSelectionStyleNone;
//  self.contentView.bounds = CGRectMake(0, 0, 9999, 9999);
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
  UIView *superview = self.contentView;
  addView(superview, self.collectionview);
  
  [self.collectionview mas_updateConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(superview).offset(SPACE);
    make.right.equalTo(superview).offset(-SPACE);
    make.bottom.equalTo(superview);
    make.height.equalTo(@(COLLECTIONHEIGHT));
  }];
//  SECONDTYPESECTIONHEIGHT*FIRSTROW + FIRSTTYPESECTIONHEIGHT*SECONDROW + 2 *(FIRSTROW + SECONDROW);
  self.collectionview.layer.cornerRadius = (SECONDTYPESECTIONHEIGHT + FIRSTTYPESECTIONHEIGHT + 2) / 50;
  self.collectionview.layer.shadowOffset  = CGSizeMake(0, 1);
  self.collectionview.layer.shadowColor   = [[UIColor blackColor] CGColor];
  self.collectionview.layer.shadowRadius  = self.collectionview.layer.cornerRadius;
  self.collectionview.layer.shadowOpacity = 0.25;
  self.collectionview.clipsToBounds       = false;
  self.collectionview.layer.masksToBounds = false;

}

- (UICollectionView *)collectionview {
  if (!_collectionview) {
    JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment     = JQCollectionViewItemsHorizontalAlignmentLeft;
    layout.itemsVerticalAlignment       = JQCollectionViewItemsVerticalAlignmentCenter;
    layout.itemsDirection               = JQCollectionViewItemsDirectionLTR;
    layout.sectionInset                 = UIEdgeInsetsMake(0, 0, 2, 0);
    layout.minimumLineSpacing           = 2;
    layout.minimumInteritemSpacing      = 2;
//    layout.estimatedItemSize            = CGSizeMake(FIRSTTYPESECTIONWIDTH, FIRSTTYPESECTIONHEIGHT);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.scrollEnabled   = false;
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    [_collectionview registerClass:[TitleCell class] forCellWithReuseIdentifier:TOPTITLECELL];
    [_collectionview registerClass:[SelectionContentCell class]
        forCellWithReuseIdentifier:SELECTCONTENTCELL];
    _collectionview.delegate   = self;
    _collectionview.dataSource = self;
  }
  return _collectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 2;
  }
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row     = indexPath.row;
  if (section == 0) {
    TitleCell *ttCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TOPTITLECELL forIndexPath:indexPath];
    return ttCell;
  }
  if (section == 1) {
    SelectionContentCell *scCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:SELECTCONTENTCELL
                                              forIndexPath:indexPath];
    return scCell;
  }
  
  return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  switch (section) {
    case 0:
      return CGSizeMake(SECONDTYPESECTIONWIDTH, SECONDTYPESECTIONHEIGHT);
    case 1:
      return CGSizeMake(FIRSTTYPESECTIONWIDTH, FIRSTTYPESECTIONHEIGHT);
  }
  return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"selection cell click",@"click:(sec:%li,row:%li)",indexPath.section,indexPath.row);
}
@end
