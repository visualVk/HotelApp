//
//  CityHeaderView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/16.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityHeaderView : UICollectionReusableView
@property(nonatomic, strong) UILabel *title;
-(void)loadData;
@end
