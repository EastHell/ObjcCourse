//
//  SubscriptionsList.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscriptionsDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubscriptionsList : NSObject <SubscriptionsDataSource>

- (instancetype)initWithUserID:(NSString *)userID;

@end

NS_ASSUME_NONNULL_END
