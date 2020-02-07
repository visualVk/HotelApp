//
//  FaceController.m
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "FaceController.h"
#import <CoreMotion/CoreMotion.h>
#import "ASFCameraController.h"
#import "ASFRManager.h"
#import "ASFVideoProcessor.h"
#import "NSObject+BlockSEL.h"
#import "UserViewModel.h"
#import "ViewController.h"

@interface FaceController () <ASFCameraControllerDelegate, ASFVideoProcessorDelegate> {
  ASF_CAMERA_DATA *_offscreenIn;
  Boolean isStop;
}
@property (nonatomic, strong) ASFCameraController *cameraController;
@property (nonatomic, strong) ASFVideoProcessor *videoProcessor;
@property (nonatomic, assign) NSMutableArray *arrayAllFaceRectView;
@property (nonatomic, strong) UIImageView *faceImageView;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) QMUIButton *registerBtn;
@end

@implementation FaceController

- (void)didInitialize {
  [super didInitialize];
  // init 时做的事情请写在这里
  isStop = false;
}

- (void)initSubviews {
  [super initSubviews];
  // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // 对 self.view 的操作写在这里
  [self engineActive];
  [self initCamera];
  [self getManager];
  [self generateRootView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.cameraController startCaptureSession];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.cameraController stopCaptureSession];
  [self.videoProcessor uninitProcessor];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  self.faceImageView.layer.cornerRadius  = self.faceImageView.qmui_width / 2;
  self.faceImageView.layer.masksToBounds = YES;
}

- (void)setupNavigationItems {
  [super setupNavigationItems];
  self.title = @"人脸认证";
}

#pragma mark - 添加布局
- (void)generateRootView {
  UIView *superview = self.view;
  [self.view addSubview:self.faceImageView];
  [self.faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_safeAreaLayoutGuideTop).offset(75);
    make.height.equalTo(self.faceImageView.mas_width);
    make.left.offset(30);
    make.right.offset(-30);
  }];
  
  //    self.registerBtn = [QDUIHelper generateDarkFilledButton];
  //    [self.registerBtn setTitle:@"注册人脸" forState:UIControlStateNormal];
  //    [self.view addSubview:self.registerBtn];
  //    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
  //        make.top.equalTo(self.faceImageView.mas_bottom).offset(20);
  //    }];
  //    __weak __typeof(self) weakSelf = self;
  //    [self.registerBtn addTarget:self
  //                         action:[self selectorBlock:^(id _Nonnull arg) {
  //        if ([weakSelf.videoProcessor registerDetectedPerson:@"wwx"]) {
  //            QMUILogInfo(@"face register", @"注"
  //                        @"册成功，人脸名称：wwx");
  //        };
  //    }]
  //               forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 懒加载
- (UIImageView *)faceImageView {
  if (!_faceImageView) { _faceImageView = [UIImageView new]; }
  return _faceImageView;
}

#pragma mark - 初始化摄像头
- (void)initCamera {
  UIInterfaceOrientation uiOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  AVCaptureVideoOrientation videoOrientation = (AVCaptureVideoOrientation)uiOrientation;
  
  self.arrayAllFaceRectView = [NSMutableArray arrayWithCapacity:0];
  
  self.videoProcessor          = [[ASFVideoProcessor alloc] init];
  self.videoProcessor.delegate = self;
  [self.videoProcessor initProcessor];
  
  self.cameraController          = [[ASFCameraController alloc] init];
  self.cameraController.delegate = self;
  [self.cameraController setupCaptureSession:videoOrientation];
  //    [self.view addSubview:self.glView];
}
#pragma mark - 图像显示
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
  CVImageBufferRef cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer);
  ASF_CAMERA_DATA *cameraData  = [Utility getCameraDataFromSampleBuffer:sampleBuffer];
  NSArray *arrayFaceInfo       = [self.videoProcessor process:cameraData];
  CIImage *ciImage             = [CIImage imageWithCVImageBuffer:cameraFrame];
  UIImage *image               = [UIImage imageWithCIImage:ciImage];
  //    __weak __typeof__(self) weakself = self;
  dispatch_sync(dispatch_get_main_queue(), ^{
    self.faceImageView.image = image;
    if (arrayFaceInfo.count == 1) {
      ASFVideoFaceInfo *faceInfo = [arrayFaceInfo firstObject];
      if (faceInfo.face3DAngle.status == 0) {
        if (faceInfo.face3DAngle.rollAngle <= 10 && faceInfo.face3DAngle.rollAngle >= -10 &&
            faceInfo.face3DAngle.yawAngle <= 10 && faceInfo.face3DAngle.yawAngle >= -10 &&
            faceInfo.face3DAngle.pitchAngle <= 10 && faceInfo.face3DAngle.pitchAngle >= -10) {
          //          防抖
          CMGyroData *newestAccel = self.motionManager.gyroData;
          if (newestAccel.rotationRate.x < 0.000005 && newestAccel.rotationRate.y < 0.000005 &&
              newestAccel.rotationRate.z < 0.000005) {
            isStop = true;
            QMUILogInfo(@"fact one", @"face one info:%@",
                        [[DictUtils Object2Dict:faceInfo] description]);
          }
        }
      }
    } else {
      QMUILogInfo(@"face to much", @"face to much");
    }
  });
  [Utility freeCameraData:cameraData];
}

#pragma mark - 识别结果
- (void)processRecognized:(NSString *)personName {
  if (isStop && ![personName isEqualToString:@""] && personName) {
    [self.cameraController stopCaptureSession];
    NSString *result = [NSString stringWithFormat:@"%@%@", @"比对结果：", personName];
    QMUILogInfo(@"result", @"result--%@", result);
    [self.navigationController
     dismissViewControllerAnimated:YES
     completion:^{
      /// todo: 切换到主界面
      [[[UIApplication sharedApplication].windows firstObject]
       .rootViewController presentViewController:[ViewController new]
       animated:YES
       completion:nil];
    }];
  }
}
#pragma mark - 启动引擎
- (void)engineActive {
  NSString *appid           = @"ExHdKzwAUfqQexuec8epvd4GjXzpG9xQoUYGVkqYQAff";
  NSString *sdkkey          = @"4JDK1fswMDxj6ENVRTbw3gWrWXLBsHCRySvxjeDMeERN";
  ArcSoftFaceEngine *engine = [[ArcSoftFaceEngine alloc] init];
  MRESULT mr                = [engine activeWithAppId:appid SDKKey:sdkkey];
  if (mr == ASF_MOK) {
    QMUILogInfo(@"arc face engine", @"sdk激活成功");
  } else if (mr == MERR_ASF_ALREADY_ACTIVATED) {
    QMUILogInfo(@"arc face engine", @"sdk激活成功");
  } else {
    NSString *result = [NSString stringWithFormat:@"SDK激活失败：%ld", mr];
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:result
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){}]];
  }
}
#pragma mark - 陀螺仪
- (void)getManager {
  //初始化全局管理对象
  CMMotionManager *manager = [[CMMotionManager alloc] init];
  self.motionManager       = manager;
  
  if (manager.gyroAvailable) { [manager startGyroUpdates]; }
}

@end
