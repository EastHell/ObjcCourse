//
//  WallPostsList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "WallPostsList.h"
#import "WallApi.h"

@interface WallPostsList ()

@property (strong, nonatomic) NSArray<WallPost *> *wallPosts;
@property (strong, nonatomic) WallApi *wallApi;
@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString *ownerID;

@end

@implementation WallPostsList

- (instancetype)initWithOwnerID:(NSString *)ownerID {
    self = [super init];
    if (self) {
        _wallPosts = [NSArray new];
        _wallApi = [WallApi new];
        _isLoading = NO;
        _ownerID = ownerID;
    }
    return self;
}

- (NSInteger)count {
    return self.wallPosts.count;
}

- (nonnull WallPost *)wallPostAtIndex:(NSUInteger)index {
    
    return self.wallPosts[index];
}

- (void)fetchWallPostsWithCompletion:(nonnull void (^)(NSUInteger))completion {
    
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    __weak WallPostsList *weakSelf = self;
    
    [self.wallApi
     wallGetWithOwnerId:self.ownerID
     domain:nil
     offset:self.wallPosts.count
     count:50
     filter:WallApiFilterAll
     extended:NO
     fields:nil
     onSuccess:^(NSDictionary * _Nonnull json) {
         
         weakSelf.isLoading = NO;
         
         NSArray<NSDictionary *> *wallPosts = [json objectForKey:@"items"];
         
         if (!wallPosts) {
             NSLog(@"No items section in json");
             return;
         }
         
         for (NSDictionary *wallPost in wallPosts) {
             
             WallPost *newWallPost = [WallPost wallPostWithJson:wallPost];
             
             weakSelf.wallPosts = [weakSelf.wallPosts arrayByAddingObject:newWallPost];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (completion) {
                 completion(wallPosts.count);
             }             
         });
     }];
}

@end
