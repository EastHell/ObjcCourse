//
//  FollowersList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 17/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FollowersList.h"
#import "User.h"
#import "UsersApi.h"

@interface FollowersList ()

@property (strong, nonatomic) NSArray<User *> *followers;
@property (strong, nonatomic) UsersApi *usersApi;
@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString *userID;

@end

@implementation FollowersList

- (instancetype)initWithUserID:(NSString *)userID
{
    self = [super init];
    if (self) {
        _followers = [NSArray new];
        _usersApi = [UsersApi new];
        _isLoading = NO;
        _userID = userID;
    }
    return self;
}

- (NSInteger)count {
    return self.followers.count;
}

- (void)fetchFollowersWithCompletion:(nonnull void (^)(NSUInteger))completion {
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    __weak FollowersList *weakSelf = self;
    
    [self.usersApi
     usersGetFollowersWithUserId:self.userID
     offset:self.followers.count
     count:50
     fields:@[@"photo_50"]
     nameCase:UsersApiNameCaseNom
     onSuccess:^(NSDictionary * _Nonnull json) {
         
         weakSelf.isLoading = NO;
         
         NSArray<NSDictionary *> *users = [json objectForKey:@"items"];
         
         if (!users) {
             NSLog(@"No items section in json");
             return;
         }
         
         for (NSDictionary *user in users) {
             
             User *newUser = [User userWithJson:user];
             
             weakSelf.followers = [weakSelf.followers arrayByAddingObject:newUser];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (completion) {                 
                 completion(users.count);
             }
         });
    }];
}

- (User *)followerAtIndex:(NSUInteger)index {
    return self.followers[index];
}

@end
