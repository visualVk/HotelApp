//
//  RequestUtils.m
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "RequestUtils.h"
#import "DictUtils.h"
@implementation RequestUtils
+ (instancetype)shareManager {
  static dispatch_once_t onceToken;
  static RequestUtils *utils = nil;
  dispatch_once(&onceToken, ^{
    utils = [[RequestUtils alloc] initWithBaseURL:[NSURL URLWithString:MAINDOMAIN]];
  });
  return utils;
}

- (NSString *)urlConCatWithApi:(NSString *)apiUrl {
  return [NSString stringWithFormat:@"%@%@", [RequestUtils shareManager].baseURL, apiUrl];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (self) {
    self.requestSerializer.timeoutInterval = 3;
    self.requestSerializer.cachePolicy     = NSURLRequestReloadIgnoringLocalCacheData;
    self.requestSerializer                 = [AFHTTPRequestSerializer serializer];
    AFJSONResponseSerializer *response     = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues     = YES;
    self.responseSerializer                = response;
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.responseSerializer
     setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"application/json",
                                @"text/json", @"text/javascript",
                                @"text/html", nil]];
  }
  return self;
}

#pragma mark - get with dictionary query
/// <#Description#>
/// @param urlStr <#urlStr description#>
/// @param params <#params description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
- (void)RequestGetWithUrl:(NSString *)urlStr
                Parameter:(NSDictionary *)params
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
  [[RequestUtils shareManager] GET:urlStr
                        parameters:params
                          progress:nil
                           success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                           failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}

#pragma mark - get with object query
/// <#Description#>
/// @param urlStr <#urlStr description#>
/// @param object <#object description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
- (void)RequestGetWithUrl:(NSString *)urlStr
                   Object:(__autoreleasing id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
  [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  NSDictionary *dict = [DictUtils Object2Dict:object];
  [self GET:urlStr
 parameters:dict
   progress:nil
    success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}

#pragma mark - post with www-form-urlencoded
/// post with www-form-urlencoded
/// @param urlStr api
/// @param params dictionary paramaters
/// @param success success block
/// @param failure failure block
- (void)RequestPostWithUrl:(NSString *)urlStr
                 Parameter:(NSDictionary *)params
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure {
  [self.requestSerializer setValue:@"application/x-www-form-urlencoded"
                forHTTPHeaderField:@"Content-Type"];
  NSLog(@"dict:{%@}", [params description]);
  [[RequestUtils shareManager] POST:urlStr
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}

- (void)RequestPostWithUrl:(NSString *)urlStr
                    Object:(_Nullable id)object
                   Success:(SuccessBlock)success
                   Failure:(FailureBlock)failure {
  NSDictionary *dict = [DictUtils Object2Dict:object];
  [self.requestSerializer setValue:@"application/x-www-form-urlencoded"
                forHTTPHeaderField:@"Content-Type"];
  [[RequestUtils shareManager] POST:urlStr
                         parameters:dict
                           progress:nil
                            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
                            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}

#pragma mark - post binary with application/octet-stream
/// post binary file with application/octet-stream
/// @param urlStr api
/// @param binaryData binary data
/// @param success success block
/// @param failure failure block
- (void)RequestPostBinaryWithUrl:(NSString *)urlStr
                       Parameter:(NSData *)binaryData
                         Success:(SuccessBlock)success
                         Failure:(FailureBlock)failure {
  [self.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
  [self POST:urlStr
  parameters:@{
    @"binary" : binaryData
  }
    progress:nil
     success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    success(responseObject);
  }
     failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) { failure(error); }];
}
#pragma mark - delete
- (void)RequestDeleteWithUrl:(NSString *)urlStr
                      Object:(id)object
                     Success:(SuccessBlock)success
                     Failure:(FailureBlock)failure {
}

#pragma mark - put
- (void)RequestPutWithUrl:(NSString *)urlStr
                   Object:(id)object
                  Success:(SuccessBlock)success
                  Failure:(FailureBlock)failure {
}

@end
