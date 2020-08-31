//
//  MarketCollection.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketCollection : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) Photo *photo;

+ (instancetype)marketCollectionWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
