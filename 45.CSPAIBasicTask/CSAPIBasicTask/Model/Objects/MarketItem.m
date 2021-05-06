//
//  MarketItem.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "MarketItem.h"

@implementation MarketItem

@synthesize type;

+ (instancetype)marketItemWithDictionary:(NSDictionary *)dicrionary {
    
    MarketItem *newMarketItem = [MarketItem new];
    
    newMarketItem.ID = [dicrionary objectForKey:@"id"];
    newMarketItem.title = [dicrionary objectForKey:@"title"];
    newMarketItem.itemDescription = [dicrionary objectForKey:@"description"];
    newMarketItem.thumb_photo = [NSURL URLWithString:[dicrionary objectForKey:@"thumb_photo"]];
    
    newMarketItem.type = AttachmentTypeMarketItem;
    
    return newMarketItem;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [MarketItem marketItemWithDictionary:dictionary];
}

@end
