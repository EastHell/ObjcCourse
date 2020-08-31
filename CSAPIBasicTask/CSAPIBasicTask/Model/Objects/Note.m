//
//  Note.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize type;

+ (instancetype)noteWithDictionary:(NSDictionary *)dicrionary {
    
    Note *newNote = [Note new];
    
    newNote.ID = [dicrionary objectForKey:@"id"];
    newNote.title = [dicrionary objectForKey:@"title"];
    newNote.text = [dicrionary objectForKey:@"text"];
    
    newNote.type = AttachmentTypeNote;
    
    return newNote;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Note noteWithDictionary:dictionary];
}

@end
