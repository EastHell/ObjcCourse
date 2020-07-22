//
//  FollowersDataSource.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 17/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@protocol FollowersDataSource <NSObject>

@property (assign, nonatomic, readonly) NSInteger count;

- (User *)followerAtIndex:(NSUInteger)index;
- (void)fetchFollowersWithCompletion:(void(^)(NSUInteger fetchedFollowersCount))completion;

@end

NS_ASSUME_NONNULL_END
