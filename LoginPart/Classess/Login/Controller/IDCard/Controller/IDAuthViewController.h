//
//  IDAuthViewController.h
//  IDCardRecognition
//
//  Created by zhongfeng1 on 2017/2/28.
//  Copyright © 2017年 李中峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDInfo.h"
@interface IDAuthViewController : UIViewController
@property (nonatomic, strong) void (^_Nullable IDCardBlock)(IDInfo *idInfo);
@end
