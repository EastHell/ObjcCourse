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

- (NSString *)userIDsPropertyWithUserIDs:(NSArray<NSString *> *)userIDs {
    
    return [NSString stringWithFormat:@"user_ids=%@", [userIDs componentsJoinedByString:@","]];
}

- (NSString *)fieldsPropertyWithFields:(NSArray<NSString *> *)fields {
    
    return [NSString stringWithFormat:@"fields=%@", [fields componentsJoinedByString:@","]];
}

- (NSString *)nameCasePropertyWithNameCase:(UsersApiNameCase)nameCase {
    
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
    
    NSString *userIDsProperty = [self userIDsPropertyWithUserIDs:userIds];
    if (userIDsProperty) {
        [properties addObject:userIDsProperty];
    }
    
    NSString *fieldsProperty = [self fieldsPropertyWithFields:fields];
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

- (void)UsersGetWithUserIds:(NSArray<NSString *> *)userIds
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

@end
