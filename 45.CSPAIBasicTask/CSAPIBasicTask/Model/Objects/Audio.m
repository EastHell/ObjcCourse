//
//  Audio.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 07/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Audio.h"

@implementation Audio

@synthesize type;

+ (instancetype)audioWithDictionary:(NSDictionary *)dicrionary {
    
    Audio *newAudio = [Audio new];
    
    newAudio.ID = [dicrionary objectForKey:@"id"];
    newAudio.title = [dicrionary objectForKey:@"title"];
    newAudio.artist = [dicrionary objectForKey:@"artist"];
    
    newAudio.type = AttachmentTypeAudio;
    
    return newAudio;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Audio audioWithDictionary:dictionary];
}

@end
