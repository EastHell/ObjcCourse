//
//  Document.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 10/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Document : NSObject <Attachment>

+ (instancetype)documentWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
