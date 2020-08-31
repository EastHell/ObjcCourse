//
//  SubscriptionsList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "SubscriptionsList.h"
#import "UsersApi.h"

@interface SubscriptionsList ()

@property (strong, nonatomic) NSArray<Subscription *> *subscriptions;
@property (strong, nonatomic) UsersApi *usersApi;
@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString *userID;

@end

@implementation SubscriptionsList

- (instancetype)initWithUserID:(NSString *)userID {
    self = [super init];
    if (self) {
        _subscriptions = [NSArray new];
        _usersApi = [UsersApi new];
        _isLoading = NO;
        _userID = userID;
    }
    return self;
}

- (NSInteger)count {
    return self.subscriptions.count;
}

- (void)fetchSubscriptionsWithCompletion:(nonnull void (^)(NSUInteger))completion {
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    __weak SubscriptionsList *weakSelf = self;
    
    [self.usersApi
     userGetSubscriptionsWithUserId:self.userID
     extended:YES
     offset:self.subscriptions.count
     count:50
     fields:@[@"photo_50"] onSuccess:^(NSDictionary * _Nonnull json) {
         
         weakSelf.isLoading = NO;
         
         NSArray<NSDictionary *> *subscriptions = [json objectForKey:@"items"];
         
         if (!subscriptions) {
             NSLog(@"No items section in json");
             return;
         }
         
         for (NSDictionary *subscription in subscriptions) {
             
             Subscription *newSubscription = [Subscription subscriptionWithJson:subscription];
             
             weakSelf.subscriptions = [weakSelf.subscriptions arrayByAddingObject:newSubscription];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (completion) {
                 completion(subscriptions.count);
             }             
         });
     }];
}

- (nonnull Subscription *)subscriptionAtIndex:(NSUInteger)index {
    return self.subscriptions[index];
}

@end
