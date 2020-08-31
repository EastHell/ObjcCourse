//
//  PhotosList.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 13/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "PhotosList.h"

@implementation PhotosList

@synthesize type;

+ (instancetype)photosListWithDictionary:(NSDictionary *)dicrionary {
    
    PhotosList *newPhotosList = [PhotosList new];
    
    newPhotosList.type = AttachmentTypePhotosList;
    
    return newPhotosList;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [PhotosList photosListWithDictionary:dictionary];
}

@end
