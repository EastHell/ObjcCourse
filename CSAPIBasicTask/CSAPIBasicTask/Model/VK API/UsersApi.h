//
//  UsersApi.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UsersApiFields) {
    UsersApiFieldsNone = 0,
    UsersApiFieldsSreenName = 1 << 0,
    UsersApiFieldsSex = 1 << 1,
    UsersApiFieldsBdate = 1 << 2,
    UsersApiFieldsCity = 1 << 3,
    UsersApiFieldsCountry = 1 << 4,
    UsersApiFieldsTimezone = 1 << 5,
    UsersApiFieldsPhoto = 1 << 6,
    UsersApiFieldsPhotoMedium = 1 << 7,
    UsersApiFieldsPhotoBig = 1 << 8,
    UsersApiFieldsHasMobile = 1 << 9,
    UsersApiFieldsContacts = 1 << 10,
    UsersApiFieldsEducation = 1 << 11,
    UsersApiFieldsOnline = 1 << 12,
    UsersApiFieldsCounters = 1 << 13,
    UsersApiFieldsRelation = 1 << 14,
    UsersApiFieldsLastSeen = 1 << 15,
    UsersApiFieldsActivity = 1 << 16,
    UsersApiFieldsCanWritePrivateMessage = 1 << 17,
    UsersApiFieldsCanSeeAllPosts = 1 << 18,
    UsersApiFieldsCanPost = 1 << 19,
    UsersApiFieldsUniversities = 1 << 20
};

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
                     fields:(UsersApiFields)fields
                   nameCase:(UsersApiNameCase)nameCase
                  onSuccess:(void (^)(NSDictionary *json))success;

@end

NS_ASSUME_NONNULL_END
