//
//  FriendsApi.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/05/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendsApi.h"
#import "NetworkManager.h"
#import "AccessToken.h"

static NSString * const versionProperty = @"v=5.103";

@implementation FriendsApi

#pragma mark - Utility

- (NSString *)userIdParameterWithUserId:(NSInteger)userId {
  
  NSString *result = [NSString stringWithFormat:@"user_id=%zd", userId];
  
  return result;
}

- (NSString *)orderParameterWithOrder:(FriendsApiOrder)order {
  
  switch (order) {
    case FriendsApiOrderHints:
      return @"order=hints";
    case FriendsApiOrderRandom:
      return @"order=random";
    case FriendsApiOrderMobile:
      return @"order=mobile";
    case FriendsApiOrderName:
      return @"order=name";
    case FriendsApiOrderDefault:
      return nil;
  }
}

- (NSString *)listIdParameterForListId:(NSUInteger)listId {
  
  if (listId < 1) {
    return nil;
  }
  
  NSString *result = [NSString stringWithFormat:@"list_id=%zd", listId];
  
  return result;
}

- (NSString *)countParameterForCount:(NSUInteger)count {
  
  if (count < 1) {
    return nil;
  }
  
  NSString *result = [NSString stringWithFormat:@"count=%zd", count];
  
  return result;
}

- (NSString *)offsetParameterForOffset:(NSUInteger)offset {
  
  if (offset < 1) {
    return nil;
  }
  
  NSString *result = [NSString stringWithFormat:@"offset=%zd", offset];
  
  return result;
}

- (NSString *)fieldsParameterForFields:(FriendsApiFields)fields {
  
  if (fields == 0) {
    return nil;
  }
  
  NSMutableArray *fieldsArray = [NSMutableArray array];
  
  if ((fields & FriendsApiFieldsNickname) == FriendsApiFieldsNickname) {
    [fieldsArray addObject:@"nickname"];
  }
  
  if ((fields & FriendsApiFieldsDomain) == FriendsApiFieldsDomain) {
    [fieldsArray addObject:@"domain"];
  }
  
  if ((fields & FriendsApiFieldsSex) == FriendsApiFieldsSex) {
    [fieldsArray addObject:@"sex"];
  }
  
  if ((fields & FriendsApiFieldsBdate) == FriendsApiFieldsBdate) {
    [fieldsArray addObject:@"bdate"];
  }
  
  if ((fields & FriendsApiFieldsCity) == FriendsApiFieldsCity) {
    [fieldsArray addObject:@"city"];
  }
  
  if ((fields & FriendsApiFieldsCountry) == FriendsApiFieldsCountry) {
    [fieldsArray addObject:@"country"];
  }
  
  if ((fields & FriendsApiFieldsTimezone) == FriendsApiFieldsTimezone) {
    [fieldsArray addObject:@"timezone"];
  }
  
  if ((fields & FriendsApiFieldsPhoto50) == FriendsApiFieldsPhoto50) {
    [fieldsArray addObject:@"photo_50"];
  }
  
  if ((fields & FriendsApiFieldsPhoto100) == FriendsApiFieldsPhoto100) {
    [fieldsArray addObject:@"photo_100"];
  }
  
  if ((fields & FriendsApiFieldsPhoto200Orig) == FriendsApiFieldsPhoto200Orig) {
    [fieldsArray addObject:@"photo_200_orig"];
  }
  
  if ((fields & FriendsApiFieldsHasMobile) == FriendsApiFieldsHasMobile) {
    [fieldsArray addObject:@"has_mobile"];
  }
  
  if ((fields & FriendsApiFieldsContacts) == FriendsApiFieldsContacts) {
    [fieldsArray addObject:@"contacts"];
  }
  
  if ((fields & FriendsApiFieldsEducation) == FriendsApiFieldsEducation) {
    [fieldsArray addObject:@"education"];
  }
  
  if ((fields & FriendsApiFieldsOnline) == FriendsApiFieldsOnline) {
    [fieldsArray addObject:@"online"];
  }
  
  if ((fields & FriendsApiFieldsRelation) == FriendsApiFieldsRelation) {
    [fieldsArray addObject:@"relation"];
  }
  
  if ((fields & FriendsApiFieldsLastSeen) == FriendsApiFieldsLastSeen) {
    [fieldsArray addObject:@"last_seen"];
  }
  
  if ((fields & FriendsApiFieldsStatus) == FriendsApiFieldsStatus) {
    [fieldsArray addObject:@"status"];
  }
  
  if ((fields & FriendsApiFieldsCanWritePrivateMessage) == FriendsApiFieldsCanWritePrivateMessage) {
    [fieldsArray addObject:@"can_write_private_message"];
  }
  
  if ((fields & FriendsApiFieldsCanSeeAllPosts) == FriendsApiFieldsCanSeeAllPosts) {
    [fieldsArray addObject:@"can_see_all_posts"];
  }
  
  if ((fields & FriendsApiFieldsCanPost) == FriendsApiFieldsCanPost) {
    [fieldsArray addObject:@"can_post"];
  }
  
  if ((fields & FriendsApiFieldsUniversities) == FriendsApiFieldsUniversities) {
    [fieldsArray addObject:@"universities"];
  }
  
  NSString *fieldsString = [fieldsArray componentsJoinedByString:@","];
  NSString *result = [NSString stringWithFormat:@"fields=%@", fieldsString];
  
  return result;
}

- (NSString *)nameCasePropertyWithNameCase:(FriendsApiNameCase)nameCase {
  
  switch (nameCase) {
    case FriendsApiNameCaseNom:
      return @"name_case=nom";
    case FriendsApiNameCaseGen:
      return @"name_case=gen";
    case FriendsApiNameCaseDat:
      return @"name_case=dat";
    case FriendsApiNameCaseAcc:
      return @"name_case=acc";
    case FriendsApiNameCaseIns:
      return @"name_case=ins";
    case FriendsApiNameCaseAbl:
      return @"name_case=abl";
    case FriendsApiNameCaseDefault:
      return nil;
  }
}

- (NSString *)propertiesWithUserId:(NSInteger)userId
                             order:(FriendsApiOrder)order
                            listId:(NSUInteger)listId
                             count:(NSUInteger)count
                            offset:(NSUInteger)offset
                            fields:(FriendsApiFields)fields
                          nameCase:(FriendsApiNameCase)nameCase {
  
  NSMutableArray *properties = [NSMutableArray array];
  
  NSString *userIdProperty = [self userIdParameterWithUserId:userId];
  if (userIdProperty) {
    [properties addObject:userIdProperty];
  }
  
  NSString *orderProperty = [self orderParameterWithOrder:order];
  if (orderProperty) {
    [properties addObject:orderProperty];
  }
  
  NSString *listIdProperty = [self listIdParameterForListId:listId];
  if (listIdProperty) {
    [properties addObject:listIdProperty];
  }
  
  NSString *countProperty = [self countParameterForCount:count];
  if (countProperty) {
    [properties addObject:countProperty];
  }
  
  NSString *offsetProperty = [self offsetParameterForOffset:offset];
  if (offsetProperty) {
    [properties addObject:offsetProperty];
  }
  
  NSString *fieldsProperty = [self fieldsParameterForFields:fields];
  if (fieldsProperty) {
    [properties addObject:fieldsProperty];
  }
  
  NSString *nameCaseProperty = [self nameCasePropertyWithNameCase:nameCase];
  if (nameCaseProperty) {
    [properties addObject:nameCaseProperty];
  }
  
  return [properties componentsJoinedByString:@"&"];
}

#pragma mark - Class methods

- (void)friendsGetWithUserId:(NSInteger)userId
                                 order:(FriendsApiOrder)order
                                listId:(NSUInteger)listId
                                 count:(NSUInteger)count
                                offset:(NSUInteger)offset
                                fields:(FriendsApiFields)fields
                              nameCase:(FriendsApiNameCase)nameCase
                             onSuccess:(void (^)(NSDictionary *json))success {
  
  NSString *method = @"https://api.vk.com/method/friends.get";
  
  NSString *properties = [self propertiesWithUserId:userId
                                              order:order
                                             listId:listId
                                              count:count
                                             offset:offset
                                             fields:fields
                                           nameCase:nameCase];
  
  NSString *accessToken = [AccessToken currentAcessToken].token;
  if (!accessToken) {
    NSLog(@"Access token not founded");
  }
  
  NSString *accessTokenProperty = [NSString stringWithFormat:@"access_token=%@", accessToken];
  
  NSString *urlString = [NSString stringWithFormat:
                         @"%@?%@&%@&%@",
                         method,
                         properties,
                         versionProperty,
                         accessTokenProperty];
  
  NSURL *url = [NSURL URLWithString:urlString];
  
  [[NetworkManager sharedNetwork]
   performRequestWithUrl:url
   onSuccess:^(NSData * _Nonnull data) {
     
     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     
     success([json objectForKey:@"response"]);
   }
   onFailure:^(NSError * _Nonnull error) {
     NSLog(@"%@", error);
   }];
}

@end
