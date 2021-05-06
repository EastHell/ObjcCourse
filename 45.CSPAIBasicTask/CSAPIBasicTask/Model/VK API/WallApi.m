//
//  WallApi.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "WallApi.h"
#import "NetworkManager.h"
#import "AccessToken.h"

static NSString * const versionProperty = @"v=5.120";

@implementation WallApi

#pragma mark - Utility

- (NSString *)ownerIdParameterWithOwnerId:(NSString *)ownerId {
    
    if (!ownerId) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"owner_id=%@", ownerId];
}

- (NSString *)domainParameterWithDomain:(NSString *)domain {
    
    
    if (!domain) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"domain=%@", domain];
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

- (NSString *)filterParameterWithFilter:(WallApiFilter)filter {
    
    switch (filter) {
        case WallApiFilterOwner:
            return @"filter=owner";
        case WallApiFilterOthers:
            return @"filter=others";
        case WallApiFilterAll:
            return @"filter=all";
        case WallApiFilterPostponed:
            return @"filter=postponed";
        case WallApiFilterSuggests:
            return @"filter=suggests";
    }
}

- (NSString *)fieldsParameterWithFields:(NSArray<NSString *> *)fields {
    
    if (!fields) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"fields=%@", [fields componentsJoinedByString:@","]];
}

- (NSString *)properiesWithOwnerId:(NSString *)ownerId
                            domain:(NSString *)domain
                            offset:(NSUInteger)offset
                             count:(NSUInteger)count
                            filter:(WallApiFilter)filter
                          extended:(BOOL)extended
                            fields:(NSArray<NSString *> *)fields {
    
    NSMutableArray *properties = [NSMutableArray array];
    
    NSString *ownerIdProperty = [self ownerIdParameterWithOwnerId:ownerId];
    if (ownerIdProperty) {
        [properties addObject:ownerIdProperty];
    }
    
    NSString *domainProperty = [self domainParameterWithDomain:domain];
    if (domainProperty) {
        [properties addObject:domainProperty];
    }
    
    NSString *offsetProperty = [self offsetParameterForOffset:offset];
    if (offsetProperty) {
        [properties addObject:offsetProperty];
    }
    
    NSString *countProperty = [self countParameterForCount:count];
    if (countProperty) {
        [properties addObject:countProperty];
    }
    
    NSString *filterProperty = [self filterParameterWithFilter:filter];
    if (filterProperty) {
        [properties addObject:filterProperty];
    }
    
    [properties addObject:extended?@"extended=1":@"extended=0"];
    
    NSString *fieldsProperty = [self fieldsParameterWithFields:fields];
    if (fieldsProperty) {
        [properties addObject:fieldsProperty];
    }
    
    return [properties componentsJoinedByString:@"&"];
}

#pragma mark - Class methods

- (void)wallGetWithOwnerId:(NSString *)ownerId
                    domain:(NSString * _Nullable)domain
                    offset:(NSUInteger)offset
                     count:(NSUInteger)count
                    filter:(WallApiFilter)filter
                  extended:(BOOL)extended
                    fields:(NSArray<NSString *> *)fields
                 onSuccess:(void (^)(NSDictionary *json))success {
    
    NSString *method = @"https://api.vk.com/method/wall.get";
    
    NSString *properties = [self properiesWithOwnerId:ownerId
                                               domain:domain
                                               offset:offset
                                                count:count
                                               filter:filter
                                             extended:extended
                                               fields:fields];
    
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
