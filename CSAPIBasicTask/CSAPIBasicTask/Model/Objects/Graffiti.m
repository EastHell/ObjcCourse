//
//  Graffiti.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 10/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Graffiti.h"

@implementation Graffiti

@synthesize type;

+ (instancetype)graffitiWithDictionary:(NSDictionary *)dicrionary {
    
    Graffiti *newGraffiti = [Graffiti new];
    
    newGraffiti.ID = [dicrionary objectForKey:@"id"];
    newGraffiti.photo_604 = [dicrionary objectForKey:@"photo_604"];
    
    newGraffiti.type = AttachmentTypeGraffiti;
    
    return newGraffiti;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Graffiti graffitiWithDictionary:dictionary];
}

@end
