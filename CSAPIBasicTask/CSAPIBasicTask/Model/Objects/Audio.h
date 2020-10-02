//
//  Audio.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 07/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Audio : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *title;

+ (instancetype)audioWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
