//
//  AccessToken.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccessToken : NSObject

@property (copy, nonatomic, readonly) NSString *token;

+ (instancetype)currentAcessToken;
+ (void)addToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
