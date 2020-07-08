//
//  FriendListDataSource.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/06/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Friend;

@protocol FriendListDataSource <NSObject>

@property (assign, nonatomic, readonly) NSInteger count;

- (Friend *)friendAtIndex:(NSUInteger)index;
- (void)fetchFriendsWithCompletion:(void(^)(NSUInteger fetchedFriendsCount))completion;

@end

NS_ASSUME_NONNULL_END
