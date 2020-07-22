//
//  SubscriptionsDataSource.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subscription.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SubscriptionsDataSource <NSObject>

@property (assign, nonatomic, readonly) NSInteger count;

- (Subscription *)subscriptionAtIndex:(NSUInteger)index;
- (void)fetchSubscriptionsWithCompletion:(void(^)(NSUInteger fetchedSubscriptionsCount))completion;

@end

NS_ASSUME_NONNULL_END
