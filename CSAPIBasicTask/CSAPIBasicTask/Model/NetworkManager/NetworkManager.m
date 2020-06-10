//
//  NetworkManager.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "NetworkManager.h"

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

- (NSUInteger)performRequestWithUrl:(NSURL *)url
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
  return dataTask.taskIdentifier;
}

- (void)cancelRequestWithIdentifier:(NSUInteger)identifier {
  
  [[NSURLSession sharedSession] getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
    
    [dataTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      
      if (obj.taskIdentifier == identifier) {
        [obj cancel];
        NSLog(@"Request cancelled");
        *stop = YES;
      }
    }];
  }];
}

@end
