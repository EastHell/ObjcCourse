//
//  FriendList.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 20/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface FriendList : NSObject

@property (assign, nonatomic, readonly) NSInteger count;

- (User *)userAtIndex:(NSUInteger)index;
- (void)loadMoreWithCompletion:(void(^)(NSUInteger count))completion;

@end

NS_ASSUME_NONNULL_END
