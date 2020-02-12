//
//  ImageCollectionController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/8.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ImageCollectionController.h"
#import <TYCyclePagerView.h>
#import <TYPageControl.h>
#import "TYCyclePagerViewCell.h"
@interface ImageCollectionController () <UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
//@property (nonatomic, strong) UICollectionView *collection;
@end

@implementation ImageCollectionController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
  [self generateRootView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"";
}

#pragma mark - generate root view
- (void)generateRootView {
  QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
                                            initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
  layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
  layout.estimatedItemSize                = CGSizeMake(30, 200);
  layout.minimumInteritemSpacing = 20;
  layout.minimumLineSpacing      = 0;
  self.collectionView =
  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = [UIColor clearColor];
  [self.collectionView registerClass:[TYCyclePagerViewCell class]
          forCellWithReuseIdentifier:@"cellcycler"];
  self.collectionView.delegate   = self;
  self.collectionView.dataSource = self;
  [self.view addSubview:self.collectionView];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
    make.edges.equalTo(self.view);
    make.width.equalTo(self.view);
  }];


}

//- (UICollectionView *)collectionView {
//  if (!_collectionView) {
//    QMUICollectionViewPagingLayout *layout = [[QMUICollectionViewPagingLayout alloc]
//                                              initWithStyle:QMUICollectionViewPagingLayoutStyleDefault];
//    layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
//    layout.itemSize                = CGSizeMake(200, 200);
//    layout.minimumInteritemSpacing = 20;
//    layout.minimumLineSpacing      = 0;
//    _collectionView =
//    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    _collectionView.backgroundColor = [UIColor clearColor];
//    [_collectionView registerClass:[TYCyclePagerViewCell class]
//        forCellWithReuseIdentifier:@"cellcycler"];
//    _collectionView.delegate   = self;
//    _collectionView.dataSource = self;
//  }
//  return _collectionView;
//}

#pragma mark - collection delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  TYCyclePagerViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:@"cellcycler" forIndexPath:indexPath];
  
  cell.imageview.image = [UIImage imageNamed:@"profile_background"];
  
  return cell;
}

@end
