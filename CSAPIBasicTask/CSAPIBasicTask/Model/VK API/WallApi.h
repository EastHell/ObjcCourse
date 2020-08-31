//
//  WallApi.h
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WallApiFilter) {
    WallApiFilterOwner,
    WallApiFilterOthers,
    WallApiFilterAll,
    WallApiFilterPostponed,
    WallApiFilterSuggests
};

@interface WallApi : NSObject

- (void)wallGetWithOwnerId:(NSString *)ownerId
                    domain:(NSString * _Nullable)domain
                    offset:(NSUInteger)offset
                     count:(NSUInteger)count
                    filter:(WallApiFilter)filter
                  extended:(BOOL)extended
                    fields:(NSArray<NSString *> * _Nullable)fields
                 onSuccess:(void (^)(NSDictionary *json))success;

@end

NS_ASSUME_NONNULL_END
