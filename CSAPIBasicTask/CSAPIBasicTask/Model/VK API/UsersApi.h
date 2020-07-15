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

- (void)UsersGetWithUserIds:(NSArray *)userIds
                     fields:(NSArray<NSString *> *)fields
                   nameCase:(UsersApiNameCase)nameCase
                  onSuccess:(void (^)(NSArray *users))success;

@end

NS_ASSUME_NONNULL_END
