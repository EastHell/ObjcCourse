//
//  NSString+Generator.m
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "NSString+Generator.h"

@implementation NSString (Generator)

+ (NSString *)randomNameWithMaxLength:(NSUInteger)length {
    
    if (length < 1) {
        return nil;
    }
    
    static NSString *letters = @"abcderfghijklmnopqrstuvwxyz";
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < 1 + arc4random_uniform((uint32_t)length); i++) {
        [string appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((uint32_t)letters.length)]];
    }
    
    return string.capitalizedString;
}

@end
