//
//  MarketCollection.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "MarketCollection.h"

@implementation MarketCollection

@synthesize type;

+ (instancetype)marketCollectionWithDictionary:(NSDictionary *)dicrionary {
    
    MarketCollection *newMarketCollection = [MarketCollection new];
    
    newMarketCollection.ID = [dicrionary objectForKey:@"id"];
    newMarketCollection.title = [dicrionary objectForKey:@"title"];
    newMarketCollection.photo = [Photo photoWithDictionary:[dicrionary objectForKey:@"photo"]];
    
    newMarketCollection.type = AttachmentTypeMarketCollection;
    
    return newMarketCollection;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [MarketCollection marketCollectionWithDictionary:dictionary];
}

@end
