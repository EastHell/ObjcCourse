//
//  UserInfoDataSource.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 12/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@protocol UserInfoDataSource <NSObject>

- (void)fetchUserInfoForUserId:(NSString *)userID
                withCompletion:(void(^)(User *fetchedUser))completion;

@end

NS_ASSUME_NONNULL_END
