//
//  UsersApi.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UsersApiNameCase) {
    UsersApiNameCaseNom,
    UsersApiNameCaseGen,
    UsersApiNameCaseDat,
    UsersApiNameCaseAcc,
    UsersApiNameCaseIns,
    UsersApiNameCaseAbl,
    UsersApiNameCaseDefault
};

@interface UsersApi : NSObject

- (void)usersGetWithUserIds:(NSArray *)userIds
                     fields:(NSArray<NSString *> *)fields
                   nameCase:(UsersApiNameCase)nameCase
                  onSuccess:(void (^)(NSArray *users))success;

- (void)usersGetFollowersWithUserId:(NSString *)userID
                             offset:(NSUInteger)offset
                              count:(NSUInteger)count
                             fields:(NSArray<NSString *> *)fields
                           nameCase:(UsersApiNameCase)nameCase
                          onSuccess:(void (^)(NSDictionary *json))success;

- (void)userGetSubscriptionsWithUserId:(NSString *)userID
                              extended:(BOOL)extended
                                offset:(NSUInteger)offset
                                 count:(NSUInteger)count
                                fields:(NSArray<NSString *> *)fields
                             onSuccess:(void (^)(NSDictionary *json))success;

@end

NS_ASSUME_NONNULL_END
