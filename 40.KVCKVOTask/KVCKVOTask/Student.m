//
//  Student.m
//  KVCKVOTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstName = @"";
        self.lastName = @"";
        self.dateOfBirth = [NSDate new];
        self.gender = StudentGenderMale;
        self.grade = 1;
    }
    return self;
}

- (void)reset {
    [self willChangeValueForKey:@"firstName"];
    _firstName = @"";
    [self didChangeValueForKey:@"firstName"];
    
    [self willChangeValueForKey:@"lastName"];
    _lastName = @"";
    [self didChangeValueForKey:@"lastName"];
    
    [self willChangeValueForKey:@"dateOfBirth"];
    _dateOfBirth = [NSDate new];
    [self didChangeValueForKey:@"dateOfBirth"];
    
    [self willChangeValueForKey:@"gender"];
    _gender = StudentGenderMale;
    [self didChangeValueForKey:@"gender"];
    
    [self willChangeValueForKey:@"grade"];
    _grade = 1;
    [self didChangeValueForKey:@"grade"];
}

@end
