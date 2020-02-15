//
//  HotHeaderView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "HotHeaderView.h"
#import "MarkUtils.h"
@interface HotItemCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *label;
@end

@implementation HotItemCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.clearColor;
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)generateRootView {
  UIView *superview          = self.contentView;
  self.imageview             = [UIImageView new];
  self.imageview.image       = UIImageMake(@"selection");
  self.imageview.contentMode = QMUIImageResizingModeScaleAspectFit;
  self.label                 = [UILabel new];
  self.label.font            = UIFontMake(15);
  self.label.text            = @"精选";
  self.label.textColor       = UIColor.qd_mainTextColor;
  
  addView(superview, self.imageview);
  addView(superview, self.label);
  
  [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview);
    make.bottom.equalTo(self.label.mas_top);
    make.width.equalTo(self.imageview.mas_height);
    make.top.equalTo(superview);
  }];
  
  [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.imageview);
    make.bottom.equalTo(superview);
  }];
}
@end

#import "FooterEmptyView.h"
#import "HorizontalWithVerticalSectionLayout.h"
#import "NSObject+BlockSEL.h"
#import "TitleCell.h"
#define TITLEITEMCELL @"titleitemcell"
#define HOTITEMCELL @"hotitemcell"
#define ITEMWIDTH (DEVICE_WIDTH - 2 * SPACE) / 4
#define ITEMHEIGHT ITEMWIDTH
#define HOTHEADERFOOTCELL @"emptycell"

@interface HotModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagename;
@end

@implementation HotModel

@end

@interface HotHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource,
GenerateEntityDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray<HotModel *> *picArr;
@end

@implementation HotHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    HotModel *selection = [[HotModel alloc] init];
    selection.title     = @"精选";
    selection.imagename = @"selection";
    HotModel *scene     = [HotModel new];
    scene.title         = @"景点";
    scene.imagename     = @"scene";
    HotModel *food      = [HotModel new];
    food.title          = @"饮食";
    food.imagename      = @"food";
    HotModel *hotel     = [HotModel new];
    hotel.title         = @"酒店";
    hotel.imagename     = @"hotel";
    self.picArr         = @[ selection, scene, food, hotel ];
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - generate root view
- (void)generateRootView {
  self.backgroundColor = UIColor.qd_backgroundColor;
  addView(self, self.collectionview);
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@(1.5 * ITEMWIDTH + SPACE));
    make.left.equalTo(self).offset(SPACE);
    make.right.equalTo(self).offset(-SPACE);
    make.top.bottom.equalTo(self);
  }];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionview {
  if (!_collectionview) {
    QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                              initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.scrollDirection                  = UICollectionViewScrollDirectionVertical;
    layout.itemSize                         = CGSizeMake(ITEMWIDTH, ITEMWIDTH);
    layout.minimumLineSpacing               = 0;
    layout.minimumInteritemSpacing          = 0;
    layout.sectionInset                     = UIEdgeInsetsMake(SPACE, 0, 0, 0);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.scrollEnabled        = false;
    _collectionview.backgroundColor      = UIColor.clearColor;
    [_collectionview registerClass:[TitleCell class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:TITLEITEMCELL];
    [_collectionview registerClass:[FooterEmptyView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
               withReuseIdentifier:HOTHEADERFOOTCELL];
    [_collectionview registerClass:[HotItemCell class] forCellWithReuseIdentifier:HOTITEMCELL];
    _collectionview.dataSource = self;
    _collectionview.delegate   = self;
  }
  return _collectionview;
}

#pragma mark - collection view delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 4;
  }
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  NSInteger row     = indexPath.row;
  if (section == 0) {
    HotItemCell *hiCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:HOTITEMCELL forIndexPath:indexPath];
    hiCell.imageview.image = UIImageMake(self.picArr[row].imagename);
    hiCell.label.text      = self.picArr[row].title;
    return hiCell;
  }
  
  return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section == 0) {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      TitleCell *tCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                            withReuseIdentifier:TITLEITEMCELL
                                                                   forIndexPath:indexPath];
      tCell.moreBtn.hidden = YES;
      tCell.title.font     = UIFontBoldMake(18);
      tCell.title.text     = @"热门推荐";
      return tCell;
    } else {
      FooterEmptyView *footView =
      [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                         withReuseIdentifier:HOTHEADERFOOTCELL
                                                forIndexPath:indexPath];
      return footView;
    }
  }
  UICollectionReusableView *view = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
  return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(DEVICE_WIDTH - 2 * SPACE, ITEMWIDTH / 2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  QMUILogInfo(@"hot header view",@"click(sec = %li, row = %li)",indexPath.section,indexPath.row);
}
@end
