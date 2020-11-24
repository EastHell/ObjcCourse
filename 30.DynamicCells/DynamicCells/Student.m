//
//  Student.m
//  DynamicCells
//
//  Created by Aleksandr on 11/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName:(NSString *)name SecondName:(NSString *)secondName Average:(NSInteger)average
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _secondName = [secondName copy];
        _average = average;
    }
    return self;
}

@end
