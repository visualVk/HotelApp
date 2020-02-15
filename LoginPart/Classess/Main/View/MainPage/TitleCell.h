//
//  TitleView.h
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCell : UICollectionViewCell <GenerateEntityDelegate>
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) QMUIButton *moreBtn;
@end
