//
//  MainController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//
#import "MainController.h"
#import "BannerCell.h"
#import "BannerView.h"
#import "CustomSectionCell.h"
#import "HotCell.h"
#import "ImageReFreshHeader.h"
#import "MainPrefixHeader.h"
#import "MarkUtils.h"
#import "NSObject+BlockSEL.h"
#import "SearchView.h"
#import "SelectionCell.h"
#import "TicketCell.h"
#define FifthHeight UIScreen.mainScreen.bounds.size.height / 5
#define ForthHeight UIScreen.mainScreen.bounds.size.height / 4
#define TenthHeight UIScreen.mainScreen.bounds.size.height / 10
#define FifteenthHeight UIScreen.mainScreen.bounds.size.height / 10
#define OFFSETY DEVICE_HEIGHT / 10 + 44
#define SAFETOPINSET SafeAreaInsetsConstantForDeviceWithNotch.bottom
#define SAFEBOTTOMINSET SafeAreaInsetsConstantForDeviceWithNotch.top
#define SAFEHEIGHT DEVICE_HEIGHT - SAFETOPINSET - SAFEBOTTOMINSET
#define TOPNOTIFICATION @"topnotification"

@interface MainController () <QMUISearchControllerDelegate, UIGestureRecognizerDelegate> {
  CGFloat offsetHeight;
  Boolean isEnableScroll;
}
@property (nonatomic, strong) NSArray<NSString *> *keywords;
@property (nonatomic, strong) NSMutableArray<NSString *> *searchResultsKeywords;
@property (nonatomic, strong) QMUISearchController *mySearchController;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIView *cview;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) QMUIButton *bottomBtn;
@property (nonatomic, strong) UICollectionView *hotCollectionview;
@property (nonatomic, assign) CGFloat totHeight;
@property (nonatomic, assign) Boolean okFlag;
@property (nonatomic, assign) CGPoint curContentOffset;
//@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation MainController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  self.okFlag     = true;
  self.searchView = [SearchView new];
  self.keywords   = @[
    @"Helps", @"Maintain", @"Liver", @"Health", @"Function", @"Supports", @"Healthy", @"Fat",
    @"Metabolism", @"Nuturally"
  ];
  self.searchResultsKeywords = [[NSMutableArray alloc] init];
  self.statusBarStyle        = [super preferredStatusBarStyle];
  self.imageList             = @[
    @"icon_moreOperation_shareChat", @"icon_moreOperation_shareChat",
    @"icon_moreOperation_shareChat", @"icon_moreOperation_shareChat"
  ];
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  
  [self generateRootView];
  //  addView(self.view, self.mySearchController.searchBar);
  //  self.mySearchController.searchBar.frame =
  //  CGRectSetY(self.mySearchController.searchBar.frame,
  //             self.navigationController.navigationBar.frame.size.height+statusBarRect.size.height);
  //  self.mySearchController.searchBar.frame = CGRectSetY(self.mySearchController.searchBar.frame,
  //  NavigationContentTop);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController.navigationBar.qmui_backgroundView setAlpha:0];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  @weakify(self);
  [RACObserve(self.tableview, qmui_currentCellHeightKeyCache) subscribeNext:^(id x) {
    @strongify(self);
    QMUICellHeightCache *cache = x;
    CGFloat curHeight;
    self.totHeight = ForthHeight + FifteenthHeight / 2;
    for (int i = 0; i < 5; ++i) {
      curHeight = [cache heightForKey:@(i)];
      self.totHeight += curHeight;
    }
  }];
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
  self.title                    = @"首页";
  self.navigationItem.titleView = self.mySearchController.searchBar;
  //  self.navigationController.navigationBar.hidden = YES;
  self.navigationController.navigationBar.opaque               = YES;
  self.mySearchController.hidesNavigationBarDuringPresentation = NO;
  //  QMUICMI.searchBarTextFieldBackgroundImage = [UIImage new];
  //  UIImage.qd_searchBarTextFieldBackgroundImage
  self.bottomBtn = [QMUIButton new];
  [self.bottomBtn setTitle:@"温州" forState:UIControlStateNormal];
  self.bottomBtn.titleLabel.font = UIFontBoldMake(16);
  [self.bottomBtn setTitleColor:UIColor.qd_backgroundColor forState:normal];
  [self.bottomBtn setImage:UIImageMake(@"bottom_arrow") forState:UIControlStateNormal];
  self.bottomBtn.imagePosition = QMUIButtonImagePositionRight;
  self.navigationItem.leftBarButtonItem =
  [[UIBarButtonItem alloc] initWithCustomView:self.bottomBtn];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.statusBarStyle;
}

#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView == self.tableview) {
    //            return self.keywords.count;
    return 6;
  }
  return self.searchResultsKeywords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  QMUITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[QMUITableViewCell alloc] initForTableView:tableView withReuseIdentifier:identifier];
  }
  
  if (tableView == self.tableview) {
    //    cell.textLabel.text = self.keywords[indexPath.row];
    if (indexPath.row == 0) {
      //      BannerCell *bCell = [tableView dequeueReusableCellWithIdentifier:@"bannercell"];
      //      bCell.datas       = self.imageList;
      //      //      [bCell updateCellAppearanceWithIndexPath:indexPath];
      //      [bCell loadData];
      return [QMUITableViewCell new];
    } else if (indexPath.row == 1) {
      CustomSectionCell *cCell =
      [tableView dequeueReusableCellWithIdentifier:@"sectioncell" forIndexPath:indexPath];
      //      cCell.frame = self.view.bounds;
      //      [cCell layoutIfNeeded];
      //      [cCell updateCellAppearanceWithIndexPath:indexPath];
      QMUILogInfo(@"custom cell", @"height:%f", CGRectGetHeight(cCell.contentView.frame));
      return cCell;
    } else if (indexPath.row == 2) {
      TicketCell *tCell =
      [tableView dequeueReusableCellWithIdentifier:@"ticketcell" forIndexPath:indexPath];
      [tCell reloadData];
      QMUILogInfo(@"ticket cell", frameAndBounds(tCell));
      return tCell;
    } else if (indexPath.row == 3) {
      SelectionCell *scell =
      [tableView dequeueReusableCellWithIdentifier:@"selectioncell" forIndexPath:indexPath];
      return scell;
    } else if (indexPath.row == 4) {
      return [QMUITableViewCell new];
    } else if (indexPath.row == 5) {
      HotCell *hCell =
      [tableView dequeueReusableCellWithIdentifier:@"hotcell" forIndexPath:indexPath];
      hCell.tableview        = self.tableview;
      self.hotCollectionview = hCell.collectionview;
      return hCell;
    } else {
      NSMutableString *str = [[NSMutableString alloc] init];
      for (int i = 0; i < 100; i++) { [str appendString:@"string"]; }
      //      cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
      cell.textLabel.text          = str;
      cell.textLabel.numberOfLines = 0;
      cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    }
  } else {
    NSString *keyword                           = self.searchResultsKeywords[indexPath.row];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithString:keyword
                                                   attributes:@{NSForegroundColorAttributeName : TableViewCellTitleLabelColor}];
    NSRange range = [keyword rangeOfString:self.mySearchController.searchBar.text];
    if (range.location != NSNotFound) {
      [attributedString addAttributes:@{NSForegroundColorAttributeName : UIColor.qd_tintColor}
                                range:range];
    }
    cell.textLabel.attributedText = attributedString;
  }
  
  [cell updateCellAppearanceWithIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  BannerView *banner = [BannerView new];
  banner.datas       = self.imageList;
  [banner loadData];
  return banner;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return ForthHeight + FifteenthHeight / 2 + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  if (indexPath.row == 0 && indexPath.section == 0) {
  //    return ForthHeight + FifteenthHeight / 2 + 10;
  //  }
  //      else if (indexPath.row == 2) {
  //        return DEVICE_WIDTH * 0.5;
  //      }
  //  return UITableViewAutomaticDimension;
  return -1;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView
      cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  if (indexPath.row == 0) { return @(self.imageList.count); }
  return @(indexPath.row);
}

#pragma mark - <QMUISearchControllerDelegate>

- (void)searchController:(QMUISearchController *)searchController
updateResultsForSearchString:(NSString *)searchString {
  [self.searchResultsKeywords removeAllObjects];
  
  for (NSString *keyword in self.keywords) {
    if ([keyword containsString:searchString]) { [self.searchResultsKeywords addObject:keyword]; }
  }
  
  [searchController.tableView reloadData];
  
  if (self.searchResultsKeywords.count == 0) {
    [searchController showEmptyViewWithText:@"没有匹配结果"
                                 detailText:nil
                                buttonTitle:nil
                               buttonAction:NULL];
  } else {
    [searchController hideEmptyView];
  }
}

- (void)willPresentSearchController:(QMUISearchController *)searchController {
  if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier
       isEqual:QDThemeIdentifierDark]) {
    self.statusBarStyle = UIStatusBarStyleLightContent;
  } else {
    self.statusBarStyle = UIStatusBarStyleDefault;
  }
  UIImage *image = UIImageMake(@"white_background");
  [self.navigationController.navigationBar setBackgroundImage:image
                                                forBarMetrics:UIBarMetricsDefault];
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)willDismissSearchController:(QMUISearchController *)searchController {
  self.statusBarStyle = [super preferredStatusBarStyle];
  UIImage *image      = [UIImageMake(@"navigationbar_background")
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)
                         resizingMode:UIImageResizingModeStretch];
  [self.navigationController.navigationBar setBackgroundImage:image
                                                forBarMetrics:UIBarMetricsDefault];
  [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 生成布局
- (void)generateRootView {
  [self.navigationController.navigationBar.qmui_backgroundContentView setAlpha:0];
  self.mySearchController = [[QMUISearchController alloc] initWithContentsViewController:self];
  self.mySearchController.searchResultsDelegate                = self;
  self.mySearchController.launchView                           = self.searchView;
  self.mySearchController.searchBar.qmui_usedAsTableHeaderView = YES;
  self.mySearchController.active                               = NO;
  [self.mySearchController.searchBar setValue:@"取消" forKey:@"cancelButtonText"];
  self.tableview = [[QMUITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
  self.tableview.estimatedRowHeight                     = 44;
  self.tableview.dataSource                             = self;
  self.tableview.delegate                               = self;
  self.tableview.showsVerticalScrollIndicator           = NO;
  self.tableview.qmui_cacheCellHeightByKeyAutomatically = YES;
  self.tableview.scrollEnabled                          = YES;
  self.tableview.separatorStyle                         = UITableViewCellSelectionStyleNone;
  [self.tableview registerClass:[QMUITableViewCell class] forCellReuseIdentifier:@"cell"];
  [self.tableview registerClass:[BannerCell class] forCellReuseIdentifier:@"bannercell"];
  [self.tableview registerClass:[CustomSectionCell class] forCellReuseIdentifier:@"sectioncell"];
  [self.tableview registerClass:[TicketCell class] forCellReuseIdentifier:@"ticketcell"];
  [self.tableview registerClass:[SelectionCell class] forCellReuseIdentifier:@"selectioncell"];
  [self.tableview registerClass:[HotCell class] forCellReuseIdentifier:@"hotcell"];
  self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(acceptMsgOfTopView:)
                                               name:TOPNOTIFICATION
                                             object:nil];
  isEnableScroll = true;
  @weakify(self);
  ImageReFreshHeader *imageHeader = [ImageReFreshHeader headerWithRefreshingBlock:^{
    @strongify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{ [self.tableview.mj_header endRefreshing]; });
  }];
  self.tableview.mj_header = imageHeader;
  
  addView(self.view, self.tableview);
  [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
    //    make.width.equalTo(self.view);
    //    make.top.equalTo(self.view.mas_top).offset(-100);
    //    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    //        make.width.equalTo(self.view);
    make.top.left.right.equalTo(self.view);
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
  }];
}


#pragma mark - 手势穿透
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

#pragma mark - 事件中心监听
- (void)acceptMsgOfTopView:(NSNotification *)notification {
  if (self.okFlag) {
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *result       = userInfo[@"flag"];
    if (result.boolValue) {
      QMUILogInfo(@"result", @"true");
    } else {
      self.hotCollectionview.scrollEnabled = YES;
      self.tableview.scrollEnabled         = NO;
      //      self.curContentOffset = self.tableview.contentOffset;
      self.curContentOffset =
      CGPointMake(self.tableview.contentOffset.x, self.tableview.contentOffset.y - OFFSETY);
      [UIView animateWithDuration:1
                            delay:0
                          options:UIViewAnimationOptionBeginFromCurrentState
                       animations:^{
        [self.tableview
         setContentOffset:CGPointMake(0, self.totHeight - NavigationContentTop)
         animated:NO];
        
      }
                       completion:^(BOOL finished){
        
      }];
      QMUICellHeightKeyCache *cache = self.tableview.qmui_currentCellHeightKeyCache;
      for (int i = 0; i < 5; ++i) {
        QMUILogInfo(@"xxx", @"section %d:%f", i, [cache heightForKey:@(i)]);
      }
      QMUILogInfo(@"result", @"false,height=%f", self.totHeight);
      self.okFlag = false;
    }
  } else {
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *result       = userInfo[@"flag"];
    if (result.boolValue) {
      self.okFlag = true;
      [self.tableview setContentOffset:self.curContentOffset animated:YES];
    }
  }
}

#pragma mark - scroll delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
//  QMUILogInfo(@"scroll will end", @"will end");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//  QMUILogInfo(@"scroll will begin", @"will begin");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  //随滚动改变navigation bar view的透明度
  CGPoint point = scrollView.contentOffset;
//  QMUILogInfo(@"scroll did", @"did scroll");
  if (point.y > self.totHeight - NavigationContentTop) {
    [[NSNotificationCenter defaultCenter] postNotificationName:TOPNOTIFICATION
                                                        object:nil
                                                      userInfo:@{
                                                        @"flag" : @(false)
                                                      }];
  }
  [self.navigationController.navigationBar.qmui_backgroundView
   setAlpha:(point.y) / NavigationBarHeight];
}
@end
