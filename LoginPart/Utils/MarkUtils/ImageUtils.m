//
//  ImageUtils.m
//  LoginPart
//
//  Created by blacksky on 2020/2/12.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "ImageUtils.h"
@implementation ImageUtils
+ (NSString *)getImagePath:(UIImage *)Image {
  NSString *filePath = nil;
  NSData *data       = nil;
  
  if (UIImagePNGRepresentation(Image) == nil) {
    data = UIImageJPEGRepresentation(Image, 0.5);
  } else {
    data = UIImagePNGRepresentation(Image);
  }
  
  //图片保存的路径
  //这里将图片放在沙盒的documents文件夹中
  NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
  
  //文件管理器
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  //把刚刚图片转换的data对象拷贝至沙盒中
  [fileManager createDirectoryAtPath:DocumentsPath
         withIntermediateDirectories:YES
                          attributes:nil
                               error:nil];
  NSString *ImagePath = [NSString stringWithFormat:@"/image%li.png", imageIndex++];
  [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath]
                       contents:data
                     attributes:nil];
  
  //得到选择后沙盒中图片的完整路径
  filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
  
  return filePath;
}

@end
