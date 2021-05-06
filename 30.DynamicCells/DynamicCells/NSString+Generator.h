//
//  NSString+Generator.h
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Generator)

+ (NSString *)randomNameWithMaxLength:(NSUInteger)length;

@end

NS_ASSUME_NONNULL_END
