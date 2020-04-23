//
//  FriendList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendList.h"
#import "NetworkManager.h"
#import "User.h"

@implementation FriendList

- (void)getFriends {
    NetworkManager *NM = [NetworkManager sharedNetwork];
    NSDictionary *properties = @{
                                 @"user_id":@"593208226",
                                 @"order":@"name",
                                 @"count":@"3",
                                 @"offset":@"0",
                                 @"fields":@"photo_50",
                                 @"name_case":@"nom",
                                 @"v":@"5.103"
                                 };
    [NM performRequestWithUrl:@"https://api.vk.com/method/" method:@"friends.get" properties:properties onSuccess:^(NSDictionary * _Nonnull data) {
        NSLog(@"SUCCES YOU JSON:\n%@", data);
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"FAILED ERROR:%@", error);
    }];
}

@end
