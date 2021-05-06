//
//  Sticker.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 14/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sticker : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSURL *photo_352;

+ (instancetype)stickerWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
