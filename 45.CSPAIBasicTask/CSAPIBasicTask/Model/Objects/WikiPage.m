//
//  WikiPage.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 13/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "WikiPage.h"

@implementation WikiPage

@synthesize type;

+ (instancetype)wikiPageWithDictionary:(NSDictionary *)dicrionary {
    
    WikiPage *newWikiPage = [WikiPage new];
    
    newWikiPage.ID = [dicrionary objectForKey:@"id"];
    newWikiPage.title = [dicrionary objectForKey:@"title"];
    
    newWikiPage.type = AttachmentTypeWikiPage;
    
    return newWikiPage;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [WikiPage wikiPageWithDictionary:dictionary];
}

@end
