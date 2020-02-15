//
//  CityController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CityController.h"
#import <JQCollectionViewAlignLayout/JQCollectionViewAlignLayout.h>
#import "GridCityCell.h"
#import "MarkUtils.h"
#define EVERCITYCELL @"evercitycell"
#define HOTCITYCELL @"hotcitycell"
#define CITYCELL @"citycell"
@interface CityController () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate>
@property (nonatomic, strong) QMUISearchController *searchController;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) NSArray *searchResultList;
@property (nonatomic, strong) NSArray *cityList;
@end

@implementation CityController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.view.backgroundColor = UIColor.qd_customBackgroundColor;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self generateRootView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.definesPresentationContext = YES;
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
  //    self.title = @"<##>";
  self.searchController.hidesNavigationBarDuringPresentation = false;
  self.navigationItem.leftBarButtonItem = NavLeftItemMake(self.searchController.searchBar);
  self.navigationItem.leftItemsSupplementBackButton = YES;
  self.definesPresentationContext                   = NO;
}

#pragma mark - UISearchBar Delegate

#pragma mark - QMUINavigationController Delegate
- (UIImage *)navigationBarBackgroundImage {
  [self.navigationController.navigationBar.qmui_backgroundView setAlpha:1];
  return UIImageMake(@"navigationbar_background");
}

#pragma mark - QMUITableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.searchResultList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  //  return self.cityList.count;
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  //  UICollectionViewCell *cell =
  //  [collectionView dequeueReusableCellWithReuseIdentifier:EVERCITYCELL forIndexPath:indexPath];
  GridCityCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:EVERCITYCELL forIndexPath:indexPath];
  cell.clipsToBounds = YES;
  return cell;
}

#pragma mark - generate root view
- (void)generateRootView {
  //  self.searchBar                = [QMUISearchBar new];
  //  self.navigationItem.titleView = self.searchBar;
  //  self.search          = [[UISearchController alloc] initWithSearchResultsController:self];
  //  self.search.delegate = self;
  self.searchController = [[QMUISearchController alloc] initWithContentsViewController:self];
  self.searchController.hidesNavigationBarDuringPresentation = false;
  self.searchController.searchBar.qmui_usedAsTableHeaderView = YES;
  addView(self.view, self.collectionview);
  [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}

#pragma mark - Lazy load CollectionView
- (UICollectionView *)collectionview {
  if (!_collectionview) {
    JQCollectionViewAlignLayout *layout     = [[JQCollectionViewAlignLayout alloc] init];
    layout.itemsHorizontalAlignment         = JQCollectionViewItemsHorizontalAlignmentCenter;
    layout.itemsVerticalAlignment           = JQCollectionViewItemsVerticalAlignmentCenter;
    layout.itemsDirection                   = JQCollectionViewItemsDirectionLTR;
    layout.minimumLineSpacing               = SPACE;
    layout.minimumInteritemSpacing          = SPACE;
    layout.sectionInset                     = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.sectionFootersPinToVisibleBounds = YES;
    layout.estimatedItemSize                = CGSizeMake(50, 50);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.backgroundColor = UIColor.clearColor;
    [_collectionview registerClass:GridCityCell.class forCellWithReuseIdentifier:EVERCITYCELL];
    _collectionview.scrollsToTop                   = YES;
    _collectionview.scrollEnabled                  = YES;
    _collectionview.alwaysBounceVertical           = YES;
    _collectionview.showsHorizontalScrollIndicator = false;
    _collectionview.delegate                       = self;
    _collectionview.dataSource                     = self;
  }
  return _collectionview;
}
@end
