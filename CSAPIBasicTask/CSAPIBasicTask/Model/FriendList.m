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
#import <UIKit/UIKit.h>

@interface FriendList ()

@property (strong, nonatomic) NetworkManager *networkManager;
@property (strong, nonatomic) NSArray<User *> *friends;
@property (strong, nonatomic) NSCache<NSString *, UIImage *> *photosCache;

@end

@implementation FriendList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkManager = [NetworkManager sharedNetwork];
        _photosCache = [[NSCache alloc] init];
        _friends = [NSArray new];
    }
    return self;
}

- (void)loadMoreWithCompletion:(void(^)(BOOL success, NSUInteger count))completion {
    
    __weak FriendList *weakSelf = self;
    
    NSDictionary *properties = @{
                                 @"user_id":@"593208226",
                                 @"order":@"name",
                                 @"count":@"20",
                                 @"offset":[NSString stringWithFormat:@"%tu", self.count],
                                 @"fields":@"photo_50",
                                 @"name_case":@"nom",
                                 @"v":@"5.103"
                                 };
    [self.networkManager performRequestWithUrl:@"https://api.vk.com/method/" method:@"friends.get" properties:properties onSuccess:^(NSData * _Nonnull data) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:nil];
        
        //NSLog(@"Requested friends json:%@", json);
        
        NSDictionary *error = [json objectForKey:@"error"];
        if (error) {
            /*NSInteger errorCode = [[error objectForKey:@"error_code"]
                                          integerValue];
            NSLog(@"Cannot request new friends. Error code: %zd", errorCode);*/
            
            completion(NO, 0);
            return;
        }
        
        //NSLog(@"SUCCES YOU JSON:\n%@", json);
        
        NSDictionary *response = [json objectForKey:@"response"];
        NSArray<NSDictionary *> *users = [response objectForKey:@"items"];
        
        NSMutableArray *newUsers = [NSMutableArray array];
        
        for (NSDictionary *user in users) {
            NSString *userID = [user objectForKey:@"id"];
            NSString *firstName = [user objectForKey:@"first_name"];
            NSString *lastName = [user objectForKey:@"last_name"];
            NSString *photoUrl = [user objectForKey:@"photo_50"];
            BOOL canAccessClosed = [user objectForKey:@"can_access_closed"];
            BOOL closed = [user objectForKey:@"is_closed"];
            NSString *trackCode = [user objectForKey:@"track_code"];
            User *newUser = [User userWithUserID:userID firstName:firstName lastName:lastName photoUrl:photoUrl
                                 canAccessClosed:canAccessClosed isClosed:closed trackCode:trackCode];
            [newUsers addObject:newUser];
        }
        
        weakSelf.friends = [weakSelf.friends arrayByAddingObjectsFromArray:newUsers];
        
        completion(YES, newUsers.count);
    } onFailure:^(NSError * _Nonnull error) {
        //NSLog(@"FAILED ERROR:%@", error);
        completion(NO, 0);
    }];
}

- (NSInteger)count {
    return self.friends.count;
}

- (User *)userAtIndex:(NSUInteger)index {
    
    //todo:
    // Extension for imageView
    // Shared uiimage cache
    
    
    User *user = self.friends[index];
    
    if ([self.photosCache objectForKey:user.userID]) {
        
        user.photo = [self.photosCache objectForKey:user.userID];
        
    } else {
        
        __weak FriendList *weakSelf = self;
        [self.networkManager performRequestWithUrl:user.photoURL onSuccess:^(NSData * _Nonnull data) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                [weakSelf.photosCache setObject:image forKey:user.userID];
                user.photo = image;
            }
        } onFailure:^(NSError * _Nonnull error) {
            //NSLog(@"Can't load image: %@", error);
        }];
        
    }
    return user;
}

@end
