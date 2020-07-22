//
//  UserInfo.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 12/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UserInfo.h"
#import "UsersApi.h"
#import "User.h"

@interface UserInfo ()

@property (strong, nonatomic) UsersApi *usersApi;
@property (assign, nonatomic) BOOL isLoading;

@end

@implementation UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _usersApi = [UsersApi new];
        _isLoading = NO;
    }
    return self;
}

- (void)fetchUserInfoForUserId:(nonnull NSString *)userID withCompletion:(nonnull void (^)(User * _Nonnull))completion {
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    __weak UserInfo *weakSelf = self;
    
    [self.usersApi
     usersGetWithUserIds:@[userID]
     fields:@[@"sex", @"bdate", @"city", @"photo_max_orig", @"counters"]
     nameCase:UsersApiNameCaseNom
     onSuccess:^(NSArray * _Nonnull users) {
         
         weakSelf.isLoading = NO;
         
         User *user = [User userWithJson:[users firstObject]];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(user);
         });
     }];
}

@end
