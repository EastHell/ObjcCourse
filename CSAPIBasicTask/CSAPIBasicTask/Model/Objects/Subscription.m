//
//  Subscription.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Subscription.h"

@implementation Subscription
	
+ (Subscription *)subscriptionWithJson:(NSDictionary *)json {
    
    Subscription *newSubscription = [Subscription new];
    
    newSubscription.ID = [json objectForKey:@"id"];
    newSubscription.type = [json objectForKey:@"type"];
    
    if ([newSubscription.type isEqualToString:@"page"]) {
        
        newSubscription.name = [json objectForKey:@"name"];
        
    } else if ([newSubscription.type isEqualToString:@"profile"]) {
        
        NSString *firstName = [json objectForKey:@"first_name"];
        NSString *lastName = [json objectForKey:@"last_name"];
        newSubscription.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }
    
    newSubscription.photo_50 = [NSURL URLWithString:[json objectForKey:@"photo_50"]];
    
    return newSubscription;
}

@end
