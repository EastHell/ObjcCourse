//
//  Card.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 18/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Card.h"

@implementation Card

+ (instancetype)cardWithDictionary:(NSDictionary *)dictionary {
    
    Card *newCard = [Card new];
    
    newCard.card_id = [dictionary objectForKey:@"card_id"];
    newCard.title = [dictionary objectForKey:@"title"];
    
    NSArray *images = [dictionary objectForKey:@"images"];
    NSMutableArray<PhotoSize *> *parsedImages = [NSMutableArray new];
    
    for (NSDictionary *image in images) {
        
        [parsedImages addObject:[PhotoSize photoSizeWithDictionary:image]];
    }
    
    newCard.images = [parsedImages copy];
    
    return newCard;
}

@end
