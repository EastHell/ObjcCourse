//
//  Video.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 07/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize type;

+ (instancetype)videoWithDictionary:(NSDictionary *)dicrionary {
    
    Video *newVideo = [Video new];
    
    newVideo.ID = [dicrionary objectForKey:@"id"];
    newVideo.title = [dicrionary objectForKey:@"title"];
    newVideo.photo_320 = [dicrionary objectForKey:@"photo_320"];
    
    newVideo.type = AttachmentTypeVideo;
    
    return newVideo;
}


+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Video videoWithDictionary:dictionary];
}

@end
