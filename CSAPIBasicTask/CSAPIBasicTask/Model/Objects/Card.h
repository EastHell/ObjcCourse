//
//  Card.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 18/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoSize.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *card_id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray<PhotoSize *> *images;

+ (instancetype)cardWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
