//
//  BannerView.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "BannerView.h"
#import "ImageAndLabelCell.h"

@interface BannerView () <UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) WMZBannerParam *param;
@property (nonatomic, strong) UICollectionView *collectionview;
@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self generateRootView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - generate root view
- (void)generateRootView {
  self.backgroundColor                 = UIColor.clearColor;
  self.layer.masksToBounds = false;
  self.clipsToBounds       = false;
  self.param                           = BannerParam()
  .wFrameSet(CGRectMake(0, 0, BannerWitdh, BannerHeight / 4))
  .wDataSet(self.datas)
  .wRepeatSet(YES)
  .wAutoScrollSet(YES)
  .wAutoScrollSecondSet(3)
  .wEventClickSet(^(id anyID, NSInteger index) { NSLog(@"index:%li", index); })
  .wCanFingerSlidingSet(YES)
  .wBannerControlImageRadiusSet(0);
  self.banner = [[WMZBannerView alloc] initConfigureWithModel:self.param];
  
  // collection
  QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                            initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
  layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
  layout.sectionInset            = UIEdgeInsetsZero;
  layout.itemSize                = CGSizeMake(1. * (BannerWitdh - 40) / 4, BannerHeight / 15);
  layout.minimumInteritemSpacing = 0;
  self.collectionview =
  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BannerWitdh - 20, BannerHeight / 15)
                     collectionViewLayout:layout];
  self.collectionview.center = CGPointMake(BannerWitdh / 2, CGRectGetHeight(self.banner.frame));
  self.collectionview.layer.cornerRadius             = BannerHeight / 80;
  self.collectionview.scrollEnabled                  = NO;
  self.collectionview.showsHorizontalScrollIndicator = NO;
  self.collectionview.backgroundColor                = UIColor.qd_backgroundColor;
  
  [self.collectionview registerClass:[ImageAndLabelCell class]
          forCellWithReuseIdentifier:@"recommondcell"];
  self.collectionview.delegate   = self;
  self.collectionview.dataSource = self;
  [self addSubview:self.banner];
  [self addSubview:self.collectionview];
  
  self.collectionview.layer.shadowOffset  = CGSizeMake(0, 1);
  self.collectionview.layer.shadowColor   = [[UIColor blackColor] CGColor];
  self.collectionview.layer.shadowRadius  = 5;
  self.collectionview.layer.shadowOpacity = 0.25;
  self.collectionview.clipsToBounds       = false;
  self.collectionview.layer.masksToBounds = false;
}

- (void)loadData {
  self.param.wDataSet(self.datas);
  [self.banner updateUI];
  [self layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"recommondcell"
                                            forIndexPath:indexPath];
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  QMUILogInfo(@"banner cell", @"click:(section:%li,row:%li)", indexPath.section, indexPath.row);
}
@end
