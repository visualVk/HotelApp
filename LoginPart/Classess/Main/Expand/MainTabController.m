//
//  MainTabController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainTabController.h"
#import "MainController.h"
#import "CityController.h"
@interface MainTabController (){
  NSArray *navArr;
}
@end

@implementation MainTabController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
//  navArr = @[NSStringFromClass([MainController class])];
//  for (NSString *name in navArr) {
//    [self addChildViewController:[self generateRootNavWithControllerName:name title:nil image:nil]];
//  }
  MainController *con = [MainController new];
  QMUINavigationController *nav = [[QMUINavigationController alloc] initWithRootViewController:con];
  QMUINavigationController *nav2 = [[QMUINavigationController alloc] initWithRootViewController:[CityController new]];
//  nav.tabBarItem.title=@"首页";
//  nav2.tabBarItem.title = @"city";
  self.viewControllers = @[nav2];
}

- (QMUINavigationController*)generateRootNavWithControllerName:(NSString*)name title:(NSString*)title image:(UIImage*)image {
  Class class = NSClassFromString(name);
  return class;
}

@end
