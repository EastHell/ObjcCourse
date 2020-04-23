//
//  NetworkManager.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+ (NetworkManager *)sharedNetwork;
- (void)performRequestWithUrl:(NSString *)url method:(NSString *)method
                   properties:(NSDictionary<NSString *,NSString *> *)properties
                    onSuccess:(void (^)(NSDictionary * _Nonnull))sucess
                    onFailure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
