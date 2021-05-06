//
//  Poll.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 13/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Poll.h"

@implementation Poll

@synthesize type;

+ (instancetype)pollWithDictionary:(NSDictionary *)dicrionary {
    
    Poll *newPoll = [Poll new];
    
    newPoll.ID = [dicrionary objectForKey:@"id"];
    newPoll.question = [dicrionary objectForKey:@"question"];
    
    newPoll.type = AttachmentTypePoll;
    
    return newPoll;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Poll pollWithDictionary:dictionary];
}

@end
