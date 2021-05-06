//
//  Worker.m
//  TableViewEditing
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Worker.h"

@implementation Worker

- (instancetype)initWithName:(NSString *)name Salary:(NSInteger)salary
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _salary = salary;
    }
    return self;
}

@end
