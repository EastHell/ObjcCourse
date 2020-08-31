//
//  PhotoSize.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoSize : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSURL *url;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger height;

+ (instancetype)photoSizeWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
