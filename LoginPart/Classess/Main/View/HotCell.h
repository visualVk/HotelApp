//
//  HotCell.h
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

@interface HotCell : QMUITableViewCell
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UICollectionView *collectionview;
@property(nonatomic, weak) UIScrollView *scrollview;
@end
