//
//  Photo.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize type;

+ (instancetype)photoWithDictionary:(NSDictionary *)dicrionary {
    
    Photo *newPhoto = [Photo new];
    
    newPhoto.ID = [dicrionary objectForKey:@"id"];
    newPhoto.album_id = [dicrionary objectForKey:@"album_id"];
    newPhoto.owner_id = [dicrionary objectForKey:@"owner_id"];
    newPhoto.user_id = [dicrionary objectForKey:@"user_id"];
    newPhoto.text = [dicrionary objectForKey:@"text"];
    
    NSArray *sizes = [dicrionary objectForKey:@"sizes"];
    NSMutableArray<PhotoSize *> *parsedSizes = [NSMutableArray new];
    
    for (NSDictionary *size in sizes) {
        
        [parsedSizes addObject:[PhotoSize photoSizeWithDictionary:size]];
    }
    
    newPhoto.sizes = [parsedSizes copy];
    
    NSNumber *width = [dicrionary objectForKey:@"width"];
    if (width) {
        newPhoto.width = [width integerValue];
    }
    
    NSNumber *height = [dicrionary objectForKey:@"height"];
    if (height) {
        newPhoto.height = [height integerValue];
    }
    
    newPhoto.type = AttachmentTypePhoto;
    
    return newPhoto;
}

+ (instancetype)attachmentWithDictionary:(NSDictionary *)dictionary {
    return [Photo photoWithDictionary:dictionary];
}

@end
