//
//  Student.m
//  TableViewSearch
//
//  Created by Aleksandr on 25/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName:(NSString *)name secondName:(NSString *)secondName birthday:(NSDate *)birthday
{
    self = [super init];
    if (self) {
        self.name = name;
        self.secondName = secondName;
        self.birthday = birthday;
    }
    return self;
}

@end
