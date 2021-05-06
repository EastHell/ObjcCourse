//
//  WallPostsList.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallPostsDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallPostsList : NSObject <WallPostsDataSource>

- (instancetype)initWithOwnerID:(NSString *)ownerID;

@end

NS_ASSUME_NONNULL_END
