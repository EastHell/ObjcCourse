//
//  Document.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 10/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Document.h"

@implementation Document

@synthesize type;

+ (instancetype)documentWithDictionary:(NSDictionary *)dicrionary {
    
    Document *newDocument = [Document new];
    
    newDocument.type = AttachmentTypeDocument;
    
    return newDocument;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Document documentWithDictionary:dictionary];
}

@end
