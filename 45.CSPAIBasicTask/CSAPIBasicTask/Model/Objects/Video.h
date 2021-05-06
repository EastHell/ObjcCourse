//
//  Video.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 07/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *photo_320;

+ (instancetype)videoWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
