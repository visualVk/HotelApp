//
//  MainTabController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "MainTabController.h"
#import "MainController.h"
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
  self.viewControllers = @[nav];
}

- (QMUINavigationController*)generateRootNavWithControllerName:(NSString*)name title:(NSString*)title image:(UIImage*)image {
  Class class = NSClassFromString(name);
  return class;
}

@end
