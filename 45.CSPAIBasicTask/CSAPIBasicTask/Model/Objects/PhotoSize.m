//
//  PhotoSize.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "PhotoSize.h"

@implementation PhotoSize

+ (instancetype)photoSizeWithDictionary:(NSDictionary *)dictionary {
    
    PhotoSize *newPhotoSize = [PhotoSize new];
    
    NSNumber *height = [dictionary objectForKey:@"height"];
    if (height) {
        newPhotoSize.height = [height integerValue];
    }
    
    NSNumber *width = [dictionary objectForKey:@"width"];
    if (width) {
        newPhotoSize.width = [width integerValue];
    }
    
    newPhotoSize.type = [dictionary objectForKey:@"type"];
    
    newPhotoSize.url = [NSURL URLWithString:[dictionary objectForKey:@"url"]];
    
    return newPhotoSize;
}

@end
