//
//  NSString+Utility.m
//  TableViewSearch
//
//  Created by Aleksandr on 26/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

+ (NSString *)randomNameWithMaxLength:(NSUInteger)length {
    if (length < 1) {
        return nil;
    }
    
    static NSString *vowels = @"aeiouy";
    static NSString *consonants = @"bcdfghjklmnpqrstvwxz";
    
    NSMutableString *name = [NSMutableString string];
    
    NSInteger randomizer = arc4random_uniform(2);
    
    for (int i = 0; i < 2 + arc4random_uniform((uint32_t)length - 2); i++) {
        NSString *letters = (i + randomizer) % 2 == 0 ? vowels : consonants;
        [name appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((uint32_t)letters.length)]];
    }
    
    return name.capitalizedString;
}

@end
