//
//  Cards.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 18/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "Cards.h"

@implementation Cards

@synthesize type;

+ (instancetype)cardsWithDictionary:(NSDictionary *)dicrionary {
    
    Cards *newCards = [Cards new];
    
    NSArray *cards = [dicrionary objectForKey:@"cards"];
    NSMutableArray<Card *> *parsedCards = [NSMutableArray new];
    
    for (NSDictionary *card in cards) {
        
        [parsedCards addObject:[Card cardWithDictionary:card]];
    }
    
    newCards.cards = [parsedCards copy];
    
    newCards.type = AttachmentTypeCards;
    
    return newCards;
}

+ (nonnull instancetype)attachmentWithDictionary:(nonnull NSDictionary *)dictionary {
    return [Cards cardsWithDictionary:dictionary];
}

@end
