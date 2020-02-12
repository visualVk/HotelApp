//
//  AppDelegate.m
//  LoginPart
//
//  Created by blacksky on 2020/2/3.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "MainController.h"
#import "QMUIConfigurationTemplate.h"
#import "Users.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - set launch screen
- (void)startLaunchingAnimation {
  UIWindow *window = self.window;
  UIView *launchScreenView =
  [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
  launchScreenView.frame = window.bounds;
  [window addSubview:launchScreenView];
  
  UIImageView *backgroundImageView  = launchScreenView.subviews[0];
  backgroundImageView.clipsToBounds = YES;
  
  // UIImageView *logoImageView = launchScreenView.subviews[1];
  UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
  
  UIView *maskView         = [[UIView alloc] initWithFrame:launchScreenView.bounds];
  maskView.backgroundColor = UIColorWhite;
  [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
  
  [launchScreenView layoutIfNeeded];
  
  [launchScreenView.constraints
   enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint *_Nonnull obj, NSUInteger idx,
                                BOOL *_Nonnull stop) {
    if ([obj.identifier isEqualToString:@"bottomAlign"]) {
      obj.active = NO;
      [NSLayoutConstraint constraintWithItem:backgroundImageView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:launchScreenView
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:NavigationContentTop]
      .active = YES;
      *stop       = YES;
    }
  }];
  
  [UIView animateWithDuration:.15
                        delay:0.9
                      options:QMUIViewAnimationOptionsCurveOut
                   animations:^{
    [launchScreenView layoutIfNeeded];
    // logoImageView.alpha = 0.0;
    copyrightLabel.alpha = 0;
  }
                   completion:nil];
  [UIView animateWithDuration:1.2
                        delay:0.9
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
    maskView.alpha            = 0;
    backgroundImageView.alpha = 0;
  }
                   completion:^(BOOL finished) { [launchScreenView removeFromSuperview]; }];
}

#pragma mark - set window
- (void)resetWindow {
  [self configurateQmuiTheme];
  if (@available(iOS 13.0, *)) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  }
  Users *users          = [Users new];
  UIViewController *con = nil;
  if (!users || !users.username || !users.password || [@"" isEqualToString:users.username] ||
      [@"" isEqualToString:users.password]) {
    con = [LoginController new];
  } else {
    con = [MainController new];
    con = [[QMUINavigationController alloc] initWithRootViewController:con];
  }
  //    LoginController *con           = [LoginController new];
  self.window.backgroundColor                           = UIColor.qd_backgroundColor;
  self.window.rootViewController                        = con;
  self.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  [self.window makeKeyAndVisible];
  [self startLaunchingAnimation];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self resetWindow];
  return YES;
}

#pragma mark - configurate qmui theme
- (void)configurateQmuiTheme {
  // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleThemeDidChangeNotification:)
                                               name:QMUIThemeDidChangeNotification
                                             object:nil];
  
  // 2. 然后设置主题的生成器
  QMUIThemeManagerCenter.defaultThemeManager.themeGenerator =
  ^__kindof NSObject *_Nonnull(NSString *_Nonnull identifier) {
    if ([identifier isEqualToString:QDThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
    return nil;
  };
  
  if (@available(iOS 13.0, *)) {
    if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) {
      QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait =
      ^__kindof NSObject<NSCopying> *_Nonnull(UITraitCollection *_Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) { return QDThemeIdentifierDark; }
        
        if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier
             isEqual:QDThemeIdentifierDark]) {
          return QDThemeIdentifierDefault;
        }
        
        return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
      };
      QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
    }
  }
  // QD自定义的全局样式渲染
  [QDCommonUI renderGlobalAppearances];
  // 预加载 QQ 表情，避免第一次使用时卡顿
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                 ^{ [QDUIHelper qmuiEmotions]; });
}

#pragma mark - handle change notification
- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
  QMUIThemeManager *manager = notification.object;
  if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;
  
  [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier
                                            forKey:QDSelectedThemeIdentifier];
  
  [QDThemeManager.currentTheme applyConfigurationTemplate];
  
  // 主题发生变化，在这里更新全局 UI 控件的 appearance
  [QDCommonUI renderGlobalAppearances];
  
  // 更新表情 icon 的颜色
  [QDUIHelper updateEmotionImages];
}

//#pragma mark - UISceneSession lifecycle

//- (UISceneConfiguration *)application:(UIApplication *)application
// configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
// options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
//    sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *>
//*)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called
//    shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as
//    they will not return.
//}

@end
