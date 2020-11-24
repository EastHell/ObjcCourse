//
//  NameAndColor.m
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "NameAndColor.h"

@implementation NameAndColor

- (instancetype)initWithColor:(UIColor *)color Name:(NSString *)name
{
    self = [super init];
    if (self) {
        _color = [color copy];
        _name = [name copy];
    }
    return self;
}

@end
