//
//  UsersApi.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UsersApi.h"
#import "NetworkManager.h"
#import "AccessToken.h"

static NSString * const versionProperty = @"v=5.103";

@implementation UsersApi

#pragma mark - Utility

- (NSString *)userIDsParameterWithUserIDs:(NSArray<NSString *> *)userIDs {
    
    return [NSString stringWithFormat:@"user_ids=%@", [userIDs componentsJoinedByString:@","]];
}

- (NSString *)userIdParameterWithUserId:(NSString *)userId {
    
    NSString *result = [NSString stringWithFormat:@"user_id=%@", userId];
    
    return result;
}

- (NSString *)offsetParameterForOffset:(NSUInteger)offset {
    
    if (offset < 1) {
        return nil;
    }
    
    NSString *result = [NSString stringWithFormat:@"offset=%zd", offset];
    
    return result;
}

- (NSString *)countParameterForCount:(NSUInteger)count {
    
    if (count < 1) {
        return nil;
    }
    
    NSString *result = [NSString stringWithFormat:@"count=%zd", count];
    
    return result;
}

- (NSString *)fieldsParameterWithFields:(NSArray<NSString *> *)fields {
    
    return [NSString stringWithFormat:@"fields=%@", [fields componentsJoinedByString:@","]];
}

- (NSString *)nameCaseParameterWithNameCase:(UsersApiNameCase)nameCase {
    
    switch (nameCase) {
        case UsersApiNameCaseNom:
            return @"name_case=nom";
        case UsersApiNameCaseGen:
            return @"name_case=gen";
        case UsersApiNameCaseDat:
            return @"name_case=dat";
        case UsersApiNameCaseAcc:
            return @"name_case=acc";
        case UsersApiNameCaseIns:
            return @"name_case=ins";
        case UsersApiNameCaseAbl:
            return @"name_case=abl";
        case UsersApiNameCaseDefault:
            return nil;
    }
}



- (NSString *)propertiesWithUserIDs:(NSArray<NSString *> *)userIds
                             fields:(NSArray<NSString *> *)fields
                           nameCase:(UsersApiNameCase)nameCase {
    
    NSMutableArray *properties = [NSMutableArray array];
    
    NSString *userIDsProperty = [self userIDsParameterWithUserIDs:userIds];
    if (userIDsProperty) {
        [properties addObject:userIDsProperty];
    }
    
    NSString *fieldsProperty = [self fieldsParameterWithFields:fields];
    if (fieldsProperty) {
        [properties addObject:fieldsProperty];
    }
    
    NSString *nameCaseProperty = [self nameCaseParameterWithNameCase:nameCase];
    if (nameCaseProperty) {
        [properties addObject:nameCaseProperty];
    }
    
    return [properties componentsJoinedByString:@"&"];
}

- (NSString *)propertiesWithUserID:(NSString *)userID
                            offset:(NSUInteger)offset
                             count:(NSUInteger)count
                            fields:(NSArray<NSString *> *)fields
                          nameCase:(UsersApiNameCase)nameCase {
    
    NSMutableArray *properties = [NSMutableArray new];
    
    NSString *userIDProperty = [self userIdParameterWithUserId:userID];
    if (userIDProperty) {
        [properties addObject:userIDProperty];
    }
    
    NSString *offsetProperty = [self offsetParameterForOffset:offset];
    if (offsetProperty) {
        [properties addObject:offsetProperty];
    }
    
    NSString *countProperty = [self countParameterForCount:count];
    if (countProperty) {
        [properties addObject:countProperty];
    }
    
    NSString *fieldsProperty = [self fieldsParameterWithFields:fields];
    if (fieldsProperty) {
        [properties addObject:fieldsProperty];
    }
    
    NSString *nameCaseProperty = [self nameCaseParameterWithNameCase:nameCase];
    if (nameCaseProperty) {
        [properties addObject:nameCaseProperty];
    }
    
    return [properties componentsJoinedByString:@"&"];
}

- (NSString *)propertiesWithUserID:(NSString *)userID
                          extended:(BOOL)extended
                            offset:(NSUInteger)offset
                             count:(NSUInteger)count
                            fields:(NSArray<NSString *> *)fields {
    
    NSMutableArray *properties = [NSMutableArray new];
    
    NSString *userIDProperty = [self userIdParameterWithUserId:userID];
    if (userIDProperty) {
        [properties addObject:userIDProperty];
    }
    
    NSString *extendedProperty = extended?@"extended=1":@"extended=0";
    if (extendedProperty) {
        [properties addObject:extendedProperty];
    }
    
    NSString *offsetProperty = [self offsetParameterForOffset:offset];
    if (offsetProperty) {
        [properties addObject:offsetProperty];
    }
    
    NSString *countProperty = [self countParameterForCount:count];
    if (countProperty) {
        [properties addObject:countProperty];
    }
    
    NSString *fieldsProperty = [self fieldsParameterWithFields:fields];
    if (fieldsProperty) {
        [properties addObject:fieldsProperty];
    }
    
    return [properties componentsJoinedByString:@"&"];
}

#pragma mark - Class methods

- (void)usersGetWithUserIds:(NSArray<NSString *> *)userIds
                     fields:(NSArray<NSString *> *)fields
                   nameCase:(UsersApiNameCase)nameCase
                  onSuccess:(void (^)(NSArray *users))success {
    
    NSString *method = @"https://api.vk.com/method/users.get";
    
    NSString *properties = [self propertiesWithUserIDs:userIds
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

- (void)usersGetFollowersWithUserId:(NSString *)userID
                             offset:(NSUInteger)offset
                              count:(NSUInteger)count
                             fields:(NSArray<NSString *> *)fields
                           nameCase:(UsersApiNameCase)nameCase
                          onSuccess:(void (^)(NSDictionary *json))success {
    
    NSString *method = @"https://api.vk.com/method/users.getFollowers";
    
    NSString *properties = [self propertiesWithUserID:userID
                                               offset:offset
                                                count:count
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

- (void)userGetSubscriptionsWithUserId:(NSString *)userID
                              extended:(BOOL)extended
                                offset:(NSUInteger)offset
                                 count:(NSUInteger)count
                                fields:(NSArray<NSString *> *)fields
                             onSuccess:(void (^)(NSDictionary *json))success {
    
    NSString *method = @"https://api.vk.com/method/users.getSubscriptions";
    
    NSString *properties = [self propertiesWithUserID:userID extended:extended offset:offset count:count fields:fields];
    
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
