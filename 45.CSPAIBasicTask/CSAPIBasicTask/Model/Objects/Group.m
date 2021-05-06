//
//  Group.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Group.h"

@implementation Group

+ (Group *)groupWithJson:(NSDictionary *)json {
    
    Group *newGroup = [Group new];
    
    newGroup.name = [json objectForKey:@"name"];
    newGroup.photo = [NSURL URLWithString:[json objectForKey:@"photo"]];
    
    return newGroup;
}

@end
