//
//  TicketCell.m
//  LoginPart
//
//  Created by blacksky on 2020/2/11.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "TicketCell.h"
#import <JQCollectionViewAlignLayout/JQCollectionViewAlignLayout.h>
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#pragma mark - ticket content

@interface TicketContentCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *hotImage;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *title;
@end

@implementation TicketContentCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview = self.contentView;
  //  superview.backgroundColor = UIColor.qmui_randomColor;
  self.imageview = [UIImageView new];
  //  self.imageview.image       = UIImageMake(@"profile_background");
  self.imageview.backgroundColor = UIColor.blackColor;
  self.imageview.contentMode     = QMUIImageResizingModeScaleAspectFill;
  self.title                     = [UILabel new];
  self.title.textColor           = UIColor.qd_backgroundColor;
  self.title.font                = UIFontMake(14);
  self.title.text                = @"xxx";
  
  addView(superview, self.imageview);
  addView(superview, self.title);
  
  [self.imageview
   mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(superview); }];
  
  [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(superview);
    make.bottom.equalTo(superview);
  }];
  
  [self layoutIfNeeded];
}

- (UIImageView *)hotImage {
  if (!_hotImage) {
    _hotImage             = [UIImageView new];
    _hotImage.contentMode = QMUIImageResizingModeScaleAspectFill;
    addView(self.contentView, _hotImage);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.equalTo(self.contentView);
    }];
  }
  return _hotImage;
}

@end

#pragma mark - text top bottom
@interface TextTopBottom : UICollectionViewCell
@property (nonatomic, strong) UILabel *topLB;
@property (nonatomic, strong) UILabel *bottomLB;
@end

@implementation TextTopBottom

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { [self generateRootView]; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  self.backgroundColor        = UIColor.clearColor;
  self.topLB                  = [UILabel new];
  self.topLB.font             = UIFontBoldMake(15);
  self.topLB.text             = @"111";
  self.topLB.textAlignment    = NSTextAlignmentCenter;
  self.bottomLB               = [UILabel new];
  self.bottomLB.font          = UIFontMake(14);
  self.bottomLB.text          = @"222";
  self.bottomLB.textColor     = UIColor.qd_placeholderColor;
  self.bottomLB.textAlignment = NSTextAlignmentCenter;
  
  addView(self.contentView, self.topLB);
  addView(self.contentView, self.bottomLB);
  
  [self.topLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.right.left.equalTo(self.contentView);
  }];
  
  [self.bottomLB mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.contentView);
    make.bottom.equalTo(self.contentView).offset(-0.01 * SPACE);
    make.top.equalTo(self.topLB.mas_bottom);
  }];
}

@end

#pragma mark - ticket cell
#import "TitleCell.h"
#define TITLECELL @"titlecell"
#define TICKETCELL @"ticketcell"
#define TEXTCELL @"textcell"
#define TOP1NUM 2
#define TOP2NUM 3
#define BOTTOMNUM 3
#define TITLECELLWIDTH (DEVICE_WIDTH - SPACE * 2.0)
#define TITLECELLHEIGHT DEVICE_HEIGHT / 20
#define TOPCELLHEIGHT (DEVICE_WIDTH - SPACE * 2.0) / 3
#define TOPCELLWIDTH (DEVICE_WIDTH - SPACE * 2.0 - 2 * (TOP2NUM - 1)) / TOP2NUM
#define TOPCELLWIDTH2 (DEVICE_WIDTH - SPACE * 2.0 - 2 * (TOP1NUM - 1)) * 0.7
#define TOPCELLWIDTH3 (DEVICE_WIDTH - SPACE * 2.0 - 2 * (TOP1NUM - 1)) * 0.3
#define BOTTOMCELLHEIGHT (DEVICE_WIDTH - SPACE * 2.0) / 6
#define BOTTOMCELLWIDTH (DEVICE_WIDTH - SPACE * 2.0 - 2 * (BOTTOMNUM - 1)) / BOTTOMNUM
@interface TicketCell () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, GenerateEntityDelegate>
//@property (nonatomic, strong) UILabel *title;
//@property (nonatomic, strong) QMUIButton *moreBtn;
@property (nonatomic, strong) UICollectionView *collectionview;
@end

@implementation TicketCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
  [super didInitializeWithStyle:style];
  // init 时做的事情请写在这里
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
  [super updateCellAppearanceWithIndexPath:indexPath];
  // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self generateRootView];
}

- (void)generateRootView {
  self.backgroundColor        = UIColor.clearColor;
  UIView *superview           = self.contentView;
  superview.autoresizingMask  = UIViewAutoresizingFlexibleHeight;
  superview.mas_key           = @"superview";
  self.collectionview.mas_key = @"collection view";
  addView(superview, self.collectionview);
  
  MASAttachKeys(self.collectionview, superview);
  
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview).with.offset(SPACE).with.priorityHigh;
    make.centerX.equalTo(superview).offset(0);
    make.width.equalTo(@(DEVICE_WIDTH - 2 * SPACE));
    make.height.equalTo(@(TOPCELLHEIGHT * 2 + BOTTOMCELLHEIGHT + 4 + TITLECELLHEIGHT))
    .with.priorityHigh;
    make.bottom.equalTo(superview.mas_bottom).with.priorityHigh;
  }];
  CGFloat cellH = TOPCELLHEIGHT * 2 + BOTTOMCELLHEIGHT + 4 + TITLECELLHEIGHT;
  
  self.collectionview.layer.cornerRadius = cellH / 50;
  
  self.collectionview.layer.shadowOffset  = CGSizeMake(0, 1);
  self.collectionview.layer.shadowColor   = UIColor.qd_mainTextColor.CGColor;
  self.collectionview.layer.shadowRadius  = 5;
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
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.scrollEnabled   = false;
    _collectionview.backgroundColor = UIColor.qd_backgroundColor;
    [_collectionview registerClass:[TicketContentCell class] forCellWithReuseIdentifier:TICKETCELL];
    [_collectionview registerClass:[TextTopBottom class] forCellWithReuseIdentifier:TEXTCELL];
    [_collectionview registerClass:[TitleCell class] forCellWithReuseIdentifier:TITLECELL];
    _collectionview.dataSource = self;
    _collectionview.delegate   = self;
  }
  return _collectionview;
}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 1;
    case 1:
      return 2;
    case 2:
      return 3;
    case 3:
      return 3;
  }
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    TitleCell *ttCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TITLECELL forIndexPath:indexPath];
    return ttCell;
  }
  if (indexPath.section == 1) {
    TicketContentCell *tCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TICKETCELL forIndexPath:indexPath];
    return tCell;
  }
  if (indexPath.section == 2) {
    TicketContentCell *tCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TICKETCELL forIndexPath:indexPath];
    return tCell;
  }
  if (indexPath.section == 3) {
    TextTopBottom *ttbCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:TEXTCELL forIndexPath:indexPath];
    return ttbCell;
  }
  return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) { return CGSizeMake(TITLECELLWIDTH, TITLECELLHEIGHT); }
  if (indexPath.section == 1) {
    if (indexPath.row == 0) return CGSizeMake(TOPCELLWIDTH2, TOPCELLHEIGHT);
    return CGSizeMake(TOPCELLWIDTH3, TOPCELLHEIGHT);
  }
  if (indexPath.section == 2) { return CGSizeMake(TOPCELLWIDTH, TOPCELLHEIGHT); }
  return CGSizeMake(BOTTOMCELLWIDTH, BOTTOMCELLHEIGHT);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"collection view", @"click-(section:%li,row:%li)", indexPath.section, indexPath.row);
}

- (void)reloadData {
  [self setNeedsLayout];
  [self layoutIfNeeded];
}
@end
