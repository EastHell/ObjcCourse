//
//  UsersApi.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UsersApi.h"

@implementation UsersApi



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

- (NSString *)propertiesWithUserIds:(NSArray *)userIds
                             fields:(UsersApiFields)fields
                           nameCase:(UsersApiNameCase)nameCase {
    
    NSMutableArray *properties = [NSMutableArray array];
    
    /*NSString *userIdsProperty = [self userIdsParameterWithUserId:userIds];
    if (userIdsProperty) {
        [properties addObject:userIdsProperty];
    }
    
    NSString *fieldsProperty = [self fieldsParameterForFields:fields];
    if (fieldsProperty) {
        [properties addObject:fieldsProperty];
    }*/
    
    NSString *nameCaseProperty = [self nameCasePropertyWithNameCase:nameCase];
    if (nameCaseProperty) {
        [properties addObject:nameCaseProperty];
    }
    
    return [properties componentsJoinedByString:@"&"];
}

- (void)UsersGetWithUserIds:(NSArray *)userIds
                     fields:(UsersApiFields)fields
                   nameCase:(UsersApiNameCase)nameCase
                  onSuccess:(void (^)(NSDictionary *json))success {
    
    NSString *method = @"https://api.vk.com/method/users.get";
    
    /*NSString *properties = [self propertiesWithUserId:userId
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
     }];*/
}

@end
