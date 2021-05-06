//
//  MarketItem.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketItem : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *itemDescription;
@property (strong, nonatomic) NSURL *thumb_photo;

+ (instancetype)marketItemWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
