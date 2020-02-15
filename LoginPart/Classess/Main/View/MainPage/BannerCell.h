//
//  BannerCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/9.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import <WMZBannerConfig.h>
#import <WMZBannerControl.h>
#import <WMZBannerFlowLayout.h>
#import <WMZBannerOverLayout.h>
#import <WMZBannerParam.h>
#import <WMZBannerView.h>
@interface BannerCell : QMUITableViewCell
@property (nonatomic, strong) NSArray *datas;
@property(nonatomic, strong) WMZBannerView *banner;
- (void)loadData;
@end
