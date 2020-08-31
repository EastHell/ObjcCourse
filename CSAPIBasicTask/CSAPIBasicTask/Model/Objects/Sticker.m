//
//  Sticker.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Sticker.h"

@implementation Sticker

@synthesize type;

+ (instancetype)stickerWithDictionary:(NSDictionary *)dicrionary {
    
    Sticker *newSticker = [Sticker new];
    
    newSticker.ID = [dicrionary objectForKey:@"id"];
    newSticker.photo_352 = [NSURL URLWithString:[dicrionary objectForKey:@"photo_352"]];
    
    newSticker.type = AttachmentTypeSticker;
    
    return newSticker;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Sticker stickerWithDictionary:dictionary];
}

@end
