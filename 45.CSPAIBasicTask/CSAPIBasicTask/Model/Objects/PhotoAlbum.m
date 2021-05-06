//
//  PhotoAlbum.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 13/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "PhotoAlbum.h"

@implementation PhotoAlbum

@synthesize type;

+ (instancetype)photoAlbumWithDictionary:(NSDictionary *)dicrionary {
    
    PhotoAlbum *newPhotoAlbum = [PhotoAlbum new];
    
    newPhotoAlbum.ID = [dicrionary objectForKey:@"id"];
    newPhotoAlbum.title = [dicrionary objectForKey:@"title"];
    newPhotoAlbum.thumb = [Photo photoWithDictionary:[dicrionary objectForKey:@"thumb"]];
    
    newPhotoAlbum.type = AttachmentTypePhotoAlbum;
    
    return newPhotoAlbum;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [PhotoAlbum photoAlbumWithDictionary:dictionary];
}

@end
