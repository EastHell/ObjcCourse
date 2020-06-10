//
//  FriendsApi.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/05/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FriendsApiOrder) {
  FriendsApiOrderHints,
  FriendsApiOrderRandom,
  FriendsApiOrderMobile,
  FriendsApiOrderName,
  FriendsApiOrderDefault
};

typedef NS_OPTIONS(NSUInteger, FriendsApiFields) {
  FriendsApiFieldsNone = 0,
  FriendsApiFieldsNickname = 1 << 0,
  FriendsApiFieldsDomain = 1 << 1,
  FriendsApiFieldsSex = 1 << 2,
  FriendsApiFieldsBdate = 1 << 3,
  FriendsApiFieldsCity = 1 << 4,
  FriendsApiFieldsCountry = 1 << 5,
  FriendsApiFieldsTimezone = 1 << 6,
  FriendsApiFieldsPhoto50 = 1 << 7,
  FriendsApiFieldsPhoto100 = 1 << 8,
  FriendsApiFieldsPhoto200Orig = 1 << 9,
  FriendsApiFieldsHasMobile = 1 << 10,
  FriendsApiFieldsContacts = 1 << 11,
  FriendsApiFieldsEducation = 1 << 12,
  FriendsApiFieldsOnline = 1 << 13,
  FriendsApiFieldsRelation = 1 << 14,
  FriendsApiFieldsLastSeen = 1 << 15,
  FriendsApiFieldsStatus = 1 << 16,
  FriendsApiFieldsCanWritePrivateMessage = 1 << 17,
  FriendsApiFieldsCanSeeAllPosts = 1 << 18,
  FriendsApiFieldsCanPost = 1 << 19,
  FriendsApiFieldsUniversities = 1 << 20
};

typedef NS_ENUM(NSUInteger, FriendsApiNameCase) {
  FriendsApiNameCaseNom,
  FriendsApiNameCaseGen,
  FriendsApiNameCaseDat,
  FriendsApiNameCaseAcc,
  FriendsApiNameCaseIns,
  FriendsApiNameCaseAbl,  
  FriendsApiNameCaseDefault
};

@interface FriendsApi : NSObject

- (void)friendsGetWithUserId:(NSInteger)userId
                                 order:(FriendsApiOrder)order
                                listId:(NSUInteger)listId
                                 count:(NSUInteger)count
                                offset:(NSUInteger)offset
                                fields:(FriendsApiFields)fields
                              nameCase:(FriendsApiNameCase)nameCase
                             onSuccess:(void (^)(NSDictionary *json))success;

@end

NS_ASSUME_NONNULL_END
