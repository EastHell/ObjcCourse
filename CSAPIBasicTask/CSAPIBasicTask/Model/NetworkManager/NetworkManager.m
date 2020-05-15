//
//  NetworkManager.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "NetworkManager.h"
#import "AccessToken.h"

static NSString *const NetworkManagerErrorDomain = @"com.NetworkManagerErrorDomain";

@interface NetworkManager ()

@end

@implementation NetworkManager

+ (NetworkManager *)sharedNetwork {
  static NetworkManager *manager = nil;
    
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[NetworkManager alloc] init];
  });
    
  return manager;
}

- (void)performRequestWithUrl:(NSURL *)url
                    onSuccess:(void (^)(NSData * _Nonnull))sucess
                    onFailure:(void (^)(NSError * _Nonnull))failure {
    
  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      if (failure) {
        failure(error);
      }
      NSLog(@"DEBUG NETWORK_MANAGER: request finished with error - %@", error);
      return;
    }
    
    if (response) {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if (httpResponse.statusCode < 200 || httpResponse.statusCode>299) {
        if (failure) {
          NSString *description = [NSString stringWithFormat:@"HTTP Response status code %zd",
                                   httpResponse.statusCode];
          NSError *error = [NSError errorWithDomain:NetworkManagerErrorDomain
                                               code:httpResponse.statusCode
                                           userInfo:@{NSLocalizedDescriptionKey:description}];
          failure(error);
        }
        return;
      }
    }
    
    if (sucess) {
      sucess(data);
    }
  }];
  
  [dataTask resume];
}

/*- (void)performRequestWithUrl:(NSString *)url onSuccess:(void (^)(NSData * _Nonnull data))sucess
                    onFailure:(void (^)(NSError * _Nonnull error))failure {
    
    NSURL *requestURL = [NSURL URLWithString:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session
                                      dataTaskWithURL:requestURL
                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,
                                                          NSError * _Nullable error) {
                                          if (error) {
                                              //NSLog(@"Request error: %@", error);
                                              if (failure) {
                                                  failure(error);
                                              }
                                          } else {
                                              //NSLog(@"Request success");
                                              if (sucess) {
                                                  sucess(data);
                                              }
                                          }
                                      }];
    [dataTask resume];
}

- (void)performRequestWithUrl:(NSString *)url method:(NSString *)method
                   properties:(NSDictionary<NSString *,NSString *> *)properties
                    onSuccess:(void (^)(NSData * _Nonnull data))sucess
                    onFailure:(void (^)(NSError * _Nonnull error))failure {
    
    AccessToken *serviceToken = [AccessToken currentAcessToken];
    if (!serviceToken) {
        //NSLog(@"Service token not finded");
        if (failure) {
            NSError *error = [NSError errorWithDomain:NetworkManagerErrorDomain code:1
                                             userInfo:@{NSLocalizedDescriptionKey:@"Service token not finded"}];
            failure(error);
        }
        return;
    }
    
    NSMutableDictionary *propertiesWithToken = [properties mutableCopy];
    [propertiesWithToken setObject:serviceToken.token forKey:@"access_token"];
    [self requestWithUrl:url method:method properties:propertiesWithToken onSuccess:^(NSData * _Nonnull data) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:nil];
        NSDictionary *error = [json objectForKey:@"error"];
        if (error) {
            NSInteger errorCode = [[error objectForKey:@"error_code"]
                                   integerValue];
            switch (errorCode) {
                case 5:
                case 28:
                {
                    //NSLog(@"Request with service token error");
                    if (failure) {
                        NSError *error = [NSError
                                          errorWithDomain:NetworkManagerErrorDomain code:errorCode
                                          userInfo:@{NSLocalizedDescriptionKey:@"Request with service token error"}];
                        failure(error);
                    }
                }
                default:
                {
                    if (failure) {
                        NSError *error = [NSError errorWithDomain:NetworkManagerErrorDomain code:errorCode
                                                         userInfo:@{NSLocalizedDescriptionKey:@"Request eror"}];
                        failure(error);
                    }
                    break;
                }
            }
            return;
        }
        if (sucess) {
            sucess(data);
        }
    } onFailure:failure];
}

- (void)requestServiceTokenOnSuccess:(void (^)(NSData * _Nonnull data))sucess
                           onFailure:(void (^)(NSError * _Nonnull error))failure {
    NSDictionary<NSString *, NSString *> *tokenRequestProperties = @{
                                                                     @"client_id":@"PUT_YOUR_CLIENT_ID",
                                                                     @"client_secret":@"PUT_YOUR_CLIENT_SECRET",
                                                                     @"v":@"5.103",
                                                                     @"grant_type":@"client_credentials"
                                                                     };
    
    [self requestWithUrl:@"https://oauth.vk.com/" method:@"access_token" properties:tokenRequestProperties
               onSuccess:sucess onFailure:failure];
}

- (void)requestWithUrl:(NSString *)url method:(NSString *)method
            properties:(NSDictionary<NSString *,NSString *> *)properties
             onSuccess:(void (^)(NSData * _Nonnull))sucess onFailure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableArray<NSString *> *propertiesAndValues = [NSMutableArray array];
    [properties
     enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
         [propertiesAndValues addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
     }];
    NSString *resultProperties = [propertiesAndValues componentsJoinedByString:@"&"];
    
    NSString *requestString = [NSString stringWithFormat:@"%@%@?%@", url, method, resultProperties];
    //NSLog(@"reqest: %@", requestString);
    NSURL *requestURL = [NSURL URLWithString:requestString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session
                                      dataTaskWithURL:requestURL
                                      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response,
                                                          NSError * _Nullable error) {
                                          if (error) {
                                              //NSLog(@"Request error: %@", error);
                                              if (failure) {
                                                  failure(error);
                                              }
                                          } else {
                                              //NSLog(@"Request success");
                                              if (sucess) {
                                                  sucess(data);
                                              }
                                          }
                                      }];
    [dataTask resume];
}*/

@end
