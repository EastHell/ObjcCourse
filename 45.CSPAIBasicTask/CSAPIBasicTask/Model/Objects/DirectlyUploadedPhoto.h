//
//  DirectlyUploadedPhoto.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 30/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface DirectlyUploadedPhoto : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *owner_id;
@property (strong, nonatomic) NSURL *photo_130;
@property (strong, nonatomic) NSURL *photo_604;

+ (instancetype)directlyUploadedPhotoWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
