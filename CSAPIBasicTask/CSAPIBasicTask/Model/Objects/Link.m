//
//  Link.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Link.h"

@implementation Link

@synthesize type;

+ (instancetype)linkWithDictionary:(NSDictionary *)dicrionary {
    
    Link *newLink = [Link new];
    
    newLink.url = [dicrionary objectForKey:@"url"];
    newLink.title = [dicrionary objectForKey:@"title"];
    newLink.photo = [Photo photoWithDictionary:[dicrionary objectForKey:@"photo"]];
    
    newLink.type = AttachmentTypeLink;
    
    return newLink;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Link linkWithDictionary:dictionary];
}

@end
