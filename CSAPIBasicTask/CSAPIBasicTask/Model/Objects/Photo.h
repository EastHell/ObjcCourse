//
//  Photo.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoSize.h"
#import "Attachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject <Attachment>

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *album_id;
@property (strong, nonatomic) NSString *owner_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSArray<PhotoSize *> *sizes;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger height;

+ (instancetype)photoWithDictionary:(NSDictionary *)dicrionary;

@end

NS_ASSUME_NONNULL_END
