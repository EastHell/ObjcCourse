//
//  FriendList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendList.h"
#import "User.h"
#import "FriendsApi.h"
#import <UIKit/UIKit.h>

@interface FriendList ()

@property (strong, nonatomic) NSArray<User *> *friends;
@property (strong, nonatomic) FriendsApi *friendsApi;

@end

@implementation FriendList

- (instancetype)init
{
    self = [super init];
    if (self) {
      _friends = [NSArray new];
      _friendsApi = [FriendsApi new];
    }
    return self;
}

- (void)loadMoreWithCompletion:(void(^)(NSUInteger count))completion {
  
  __weak FriendList *weakSelf = self;
  
  [self.friendsApi
   friendsGetWithUserId:593208226
   order:FriendsApiOrderDefault
   listId:0
   count:20
   offset:self.friends.count
   fields:FriendsApiFieldsPhoto50
   nameCase:FriendsApiNameCaseNom
   onSuccess:^(NSDictionary * _Nonnull json) {
     
     NSArray<NSDictionary *> *users = [json objectForKey:@"items"];
     
     if (!users) {
       NSLog(@"No items section in json");
       return;
     }
     
     for (NSDictionary *user in users) {
       
       User *newUser = [User userWithUserID:[user objectForKey:@"id"]
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

- (NSInteger)count {
    return self.friends.count;
}

- (User *)userAtIndex:(NSUInteger)index {
    return self.friends[index];
}

@end
