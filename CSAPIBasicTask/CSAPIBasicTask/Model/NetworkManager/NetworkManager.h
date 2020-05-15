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
- (void)performRequestWithUrl:(NSURL *)url onSuccess:(void (^)(NSData * _Nonnull data))sucess
                    onFailure:(void (^)(NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
