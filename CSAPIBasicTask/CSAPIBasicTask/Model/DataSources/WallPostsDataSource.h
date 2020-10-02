//
//  WallPostsDataSource.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallPost.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WallPostsDataSource <NSObject>

@property (assign, nonatomic, readonly) NSInteger count;

- (WallPost *)wallPostAtIndex:(NSUInteger)index;
- (void)fetchWallPostsWithCompletion:(void(^)(NSUInteger fetchedWallPostsCount))completion;

@end

NS_ASSUME_NONNULL_END
