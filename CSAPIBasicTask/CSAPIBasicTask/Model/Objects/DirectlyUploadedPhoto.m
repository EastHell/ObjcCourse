//
//  DirectlyUploadedPhoto.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 30/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "DirectlyUploadedPhoto.h"

@implementation DirectlyUploadedPhoto

@synthesize type;

+ (instancetype)directlyUploadedPhotoWithDictionary:(NSDictionary *)dicrionary {
    
    DirectlyUploadedPhoto *newPhoto = [DirectlyUploadedPhoto new];
    
    newPhoto.ID = [dicrionary objectForKey:@"id"];
    newPhoto.photo_130 = [dicrionary objectForKey:@"photo_130"];
    newPhoto.photo_604 = [dicrionary objectForKey:@"photo_604"];
    
    newPhoto.type = AttachmentTypePostedPhoto;
    
    return newPhoto;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [DirectlyUploadedPhoto directlyUploadedPhotoWithDictionary:dictionary];
}

@end
