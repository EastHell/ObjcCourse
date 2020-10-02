//
//  Cards.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 18/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cards : NSObject <Attachment>

@property (strong, nonatomic) NSArray<Card *> *cards;

+ (instancetype)cardsWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
