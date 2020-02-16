//
//  CityController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/15.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "CityController.h"
#import <JQCollectionViewAlignLayout/JQCollectionViewAlignLayout.h>
#import "CityHeaderView.h"
#import "CollectionIndexView.h"
#import "CommonCell.h"
#import "GridCityCell.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#define EVERCITYCELL @"evercitycell"
#define HOTCITYCELL @"hotcitycell"
#define CITYCELL @"citycell"
#define CITYHEADERVIEW @"cityheaderview"
#define CITYHEADERVIEWHEIGHT DEVICE_HEIGHT / 25
@interface CityController () <UICollectionViewDelegate, UICollectionViewDataSource,
JQCollectionViewAlignLayoutDelegate, QMUISearchControllerDelegate>
@property (nonatomic, strong) QMUISearchController *searchController;
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) QMUITableView *tableview;
@property (nonatomic, strong) NSArray *searchResultList;
@property (nonatomic, strong) NSArray *cityList;
@property (nonatomic, strong) NSArray *cityNameList;
@property (nonatomic, strong) CollectionIndexView *indexView;
@property (nonatomic, strong) QMUIEmptyView *tagView;
@end

@implementation CityController

- (void)didInitialize {
  self.cityList       = @[ @"温州" ];
  NSMutableArray *arr = [NSMutableArray arrayWithArray:@[ @"定位", @"热门", @"必玩" ]];
  for (int i = 0; i < 26; ++i) {
    [arr addObject:[NSString stringWithFormat:@"%c", (char)('a' + i)]];
  }
  self.cityNameList = arr;
  [super didInitialize];
  // init 时做的事情请写在这里
  self.view.backgroundColor = UIColor.qd_backgroundColor;
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
- (void)searchController:(QMUISearchController *)searchController
updateResultsForSearchString:(NSString *)searchString {
  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:15];
  for (NSString *cityName in self.cityList) {
    if ([cityName containsString:searchString]) [result addObject:cityName];
  }
  self.searchResultList = result;
  [self.searchController.tableView reloadData];
  //  self.collectionview.hidden = YES;
}

- (void)willDismissSearchController:(QMUISearchController *)searchController {
  self.tableview.hidden = YES;
  //  self.collectionview.hidden = NO;
}

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
    cell.textLabel.text = self.searchResultList[indexPath.row];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  //  return self.cityList.count;
  return self.cityNameList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger section = indexPath.section;
  if (section > 2) {
    CommonCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:CITYCELL forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    return cell;
  }
  GridCityCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:EVERCITYCELL forIndexPath:indexPath];
  cell.labelBtn.text = @"温州";
  cell.clipsToBounds = YES;
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  NSInteger section      = indexPath.section;
  CityHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                              withReuseIdentifier:CITYHEADERVIEW
                                                                     forIndexPath:indexPath];
  header.title.text = self.cityNameList[section];
  if (section > 2) {
    header.backgroundColor = UIColor.qd_placeholderColor;
  } else {
    header.backgroundColor = UIColor.qd_backgroundColor;
  }
  return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
  return CGSizeMake(CGRectGetWidth(collectionView.frame), CITYHEADERVIEWHEIGHT);
}

#pragma mark - generate root view
- (void)generateRootView {
  self.searchController = [[QMUISearchController alloc] initWithContentsViewController:self];
  self.searchController.hidesNavigationBarDuringPresentation = false;
  self.searchController.searchBar.qmui_usedAsTableHeaderView = YES;
  self.searchController.searchResultsDelegate                = self;
  self.searchController.tableView.sectionFooterHeight        = 0;
  self.searchController.tableView.sectionHeaderHeight        = 0;
  self.searchController.tableView.tableHeaderView =
  [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, NavigationContentTop)];
  self.indexView =
  [[CollectionIndexView alloc] initWithFrame:CGRectMake(0, 0, 40, 20 * self.cityNameList.count)
                                 indexTitles:self.cityNameList];
  self.indexView.center = CGPointMake(DEVICE_WIDTH - 20, CGRectGetHeight(self.view.frame) / 2);
  [self.indexView addTarget:self
                     action:[self selectorBlock:^(id _Nonnull args) {
    QMUILogInfo(@"index view", @"current:%li", self.indexView.currentIndex);
    [self.collectionview
     scrollToItemAtIndexPath:[NSIndexPath
                              indexPathForRow:0
                              inSection:((CollectionIndexView *)args)
                              .currentIndex]
     atScrollPosition:UICollectionViewScrollPositionTop
     animated:YES];
  }]
           forControlEvents:UIControlEventValueChanged];
  
  [self.indexView addTarget:self
                     action:[self selectorBlock:^(id _Nonnull args) {
    QMUILogInfo(@"index view", @"tap current:%li", self.indexView.currentIndex);
  }]
           forControlEvents:UIControlEventTouchDragEnter];
  
  addView(self.view, self.collectionview);
  addView(self.view, self.indexView);
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
    layout.minimumLineSpacing               = 0;
    layout.minimumInteritemSpacing          = SPACE;
    layout.sectionInset                     = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.sectionFootersPinToVisibleBounds = YES;
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.estimatedItemSize                = CGSizeMake(50, 50);
    _collectionview =
    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionview.backgroundColor = UIColor.clearColor;
    [_collectionview setPrefetchingEnabled:false];
    [_collectionview registerClass:GridCityCell.class forCellWithReuseIdentifier:EVERCITYCELL];
    [_collectionview registerClass:CommonCell.class forCellWithReuseIdentifier:CITYCELL];
    [_collectionview registerClass:CityHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:CITYHEADERVIEW];
    _collectionview.scrollsToTop                   = YES;
    _collectionview.scrollEnabled                  = YES;
    _collectionview.alwaysBounceVertical           = YES;
    _collectionview.showsHorizontalScrollIndicator = false;
    _collectionview.showsVerticalScrollIndicator   = false;
    _collectionview.delegate                       = self;
    _collectionview.dataSource                     = self;
  }
  return _collectionview;
}
@end
