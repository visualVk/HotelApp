//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by zhongfeng1 on 2017/2/16.
//  Copyright © 2017年 zhongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDAuthViewController.h"
#import "IDInfo.h"

@interface AVCaptureViewController : UIViewController
@property (nonatomic, weak) UIViewController *beforeController;
@property (nonatomic, strong) void (^_Nullable IDCardBlock)(IDInfo *idInfo);
@end
