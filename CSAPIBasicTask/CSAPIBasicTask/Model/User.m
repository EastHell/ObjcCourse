//
//  User.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 08/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)userWithJson:(NSDictionary *)json {
    
    User *newUser = [User new];
    
    newUser.firstName = [json objectForKey:@"first_name"];
    newUser.lastName = [json objectForKey:@"last_name"];
    
    NSDictionary *city = [json objectForKey:@"city"];
    
    newUser.city = [city objectForKey:@"title"];
    newUser.photoMaxOrigURL = [NSURL URLWithString:[json objectForKey:@"photo_max_orig"]];
    
    NSNumber *sex = [json objectForKey:@"sex"];
    newUser.sex = sex.unsignedIntegerValue;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    newUser.birthDate = [dateFormatter dateFromString:[json objectForKey:@"bdate"]];
    
    return newUser;
}

@end
