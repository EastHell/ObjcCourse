//
//  FriendList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendList.h"
#import "Friend.h"
#import "FriendsApi.h"
#import <UIKit/UIKit.h>

@interface FriendList ()

@property (strong, nonatomic) NSArray<Friend *> *friends;
@property (strong, nonatomic) FriendsApi *friendsApi;
@property (assign, nonatomic) BOOL isLoading;

@end

@implementation FriendList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _friends = [NSArray new];
        _friendsApi = [FriendsApi new];
        _isLoading = NO;
    }
    return self;
}

- (NSInteger)count {
    return self.friends.count;
}

- (Friend *)friendAtIndex:(NSUInteger)index {
    return self.friends[index];
}

- (void)fetchFriendsWithCompletion:(nonnull void (^)(NSUInteger))completion {
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    __weak FriendList *weakSelf = self;
    
    [self.friendsApi
     friendsGetWithUserId:593208226
     order:FriendsApiOrderDefault
     listId:0
     count:50
     offset:self.friends.count
     fields:FriendsApiFieldsPhoto50
     nameCase:FriendsApiNameCaseNom
     onSuccess:^(NSDictionary * _Nonnull json) {
         
         weakSelf.isLoading = NO;
         
         NSArray<NSDictionary *> *users = [json objectForKey:@"items"];
         
         if (!users) {
             NSLog(@"No items section in json");
             return;
         }
         
         for (NSDictionary *user in users) {
             
             Friend *newUser = [Friend friendWithUserID:[user objectForKey:@"id"]
                                              firstName:[user objectForKey:@"first_name"]
                                               lastName:[user objectForKey:@"last_name"]
                                               photoUrl:[NSURL URLWithString:[user objectForKey:@"photo_50"]]
                                        canAccessClosed:[user objectForKey:@"can_access_closed"]
                                               isClosed:[user objectForKey:@"is_closed"]
                                              trackCode:[user objectForKey:@"track_code"]];
             
             weakSelf.friends = [weakSelf.friends arrayByAddingObject:newUser];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(users.count);
         });
     }];
}


@end
