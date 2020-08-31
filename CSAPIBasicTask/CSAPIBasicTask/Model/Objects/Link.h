//
//  Link.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 11/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Link : NSObject <Attachment>

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) Photo *photo;

+ (instancetype)linkWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
