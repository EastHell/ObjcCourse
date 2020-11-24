//
//  ContentSources.h
//  WebTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentSources : NSObject

@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *web;
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *pdf;

@end

NS_ASSUME_NONNULL_END
