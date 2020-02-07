//
//  RequestUtils.h
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef enum HttpMethod { POST = 1, GET = 2, PUT = 3, DELETE = 4, UPDATE = 5 } HttpMethod;
typedef void (^SuccessBlock)(NSDictionary *_Nullable dict);
typedef void (^FailureBlock)(NSError *_Nullable err);
NS_ASSUME_NONNULL_BEGIN

@interface RequestUtils : AFHTTPSessionManager

+ (instancetype)shareManager;

- (void)RequestGetWithUrl:(NSString *)urlStr
                Parameter:(NSDictionary *_Nullable)params
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure;

- (void)RequestPostWithUrl:(NSString *)urlStr
                 Parameter:(NSDictionary *_Nullable)params
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure;

- (void)RequestPostWithUrl:(NSString *)urlStr
                    Object:(_Nullable id)object
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure;

- (void)RequestPostBinaryWithUrl:(NSString *)urlStr
                       Parameter:(NSData *_Nullable)binaryData
                         Success:(SuccessBlock)success
                         Failure:(FailureBlock)failure;

- (void)RequestGetWithUrl:(NSString *)urlStr
                   Object:(_Nullable id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure;

- (void)RequestPutWithUrl:(NSString *)urlStr
                   Object:(_Nullable id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure;

- (void)RequestDeleteWithUrl:(NSString *)urlStr
                      Object:(_Nullable id)object
                     Success:(SuccessBlock)success
                     Failure:(FailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
