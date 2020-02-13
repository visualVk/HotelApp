//
//  BannerView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/13.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WMZBannerConfig.h>
#import <WMZBannerControl.h>
#import <WMZBannerFlowLayout.h>
#import <WMZBannerOverLayout.h>
#import <WMZBannerParam.h>
#import <WMZBannerView.h>
#import "MainController.h"

@interface BannerView : UIView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) WMZBannerView *banner;
@property (nonatomic, strong) MainController *pCon;
- (void)loadData;
@end
