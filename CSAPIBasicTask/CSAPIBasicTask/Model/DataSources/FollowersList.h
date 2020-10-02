//
//  FollowersList.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 17/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FollowersDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface FollowersList : NSObject <FollowersDataSource>

- (instancetype)initWithUserID:(NSString *)userID;

@end

NS_ASSUME_NONNULL_END
