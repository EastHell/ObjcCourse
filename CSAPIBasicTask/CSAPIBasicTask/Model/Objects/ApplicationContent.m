//
//  ApplicationContent.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 13/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "ApplicationContent.h"

@implementation ApplicationContent

@synthesize type;

+ (instancetype)applicationContentWithDictionary:(NSDictionary *)dicrionary {
    
    ApplicationContent *newApplicationContent = [ApplicationContent new];
    
    newApplicationContent.ID = [dicrionary objectForKey:@"id"];
    newApplicationContent.photo_604 = [dicrionary objectForKey:@"photo_604"];
    
    newApplicationContent.type = AttachmentTypeApplicationContent;
    
    return newApplicationContent;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [ApplicationContent applicationContentWithDictionary:dictionary];
}

@end
