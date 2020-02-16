//
//  MainTabController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainTabController.h"
#import "CityController.h"
#import "MainController.h"
@interface MainTabController () {
  NSArray *navArr;
}
@end

@implementation MainTabController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  MainController *main = [MainController new];
  QMUINavigationController *nav1 =
  [[QMUINavigationController alloc] initWithRootViewController:main];
  main.hidesBottomBarWhenPushed = false;
  nav1.tabBarItem               = [QDUIHelper tabBarItemWithTitle:@"首页"
                                                            image:UIImageMake(@"icon_tabbar_uikit")
                                                    selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                              tag:0];
  CityController *city = [CityController new];
  QMUINavigationController *nav2 =
  [[QMUINavigationController alloc] initWithRootViewController:city];
  city.hidesBottomBarWhenPushed = false;
  nav2.tabBarItem               = [QDUIHelper tabBarItemWithTitle:@"首页"
                                                            image:UIImageMake(@"icon_tabbar_uikit")
                                                    selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")
                                                              tag:1];
  self.viewControllers = @[ nav1, nav2 ];
}

- (QMUINavigationController *)generateRootNavWithControllerName:(NSString *)name
                                                          title:(NSString *)title
                                                          image:(UIImage *)image {
  Class class = NSClassFromString(name);
  return class;
}

@end
