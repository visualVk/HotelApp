//
//  CustomSectionCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/10.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface CustomSectionCell : QMUITableViewCell
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) QMUIButton *rightLabel;
@property(nonatomic, strong) NSArray *datas;

@end
