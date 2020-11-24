//
//  Student.m
//  MapKitTask
//
//  Created by Aleksandr on 05/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "Student.h"

@interface Student ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.name = [NSString randomNameWithMaxLength:2 + arc4random_uniform(9)];
        self.secondName = [NSString randomNameWithMaxLength:2 + arc4random_uniform(9)];
        self.sex = (StudentSex)arc4random_uniform(2);
        
        NSDate *startDate = [[NSDate alloc] initWithTimeIntervalSince1970:0];
        NSTimeInterval inverval = [startDate timeIntervalSinceNow];
        self.birthDate = [[NSDate alloc] initWithTimeIntervalSince1970:arc4random_uniform(inverval)];
    }
    return self;
}

- (NSString *)getSexStringRepresentation {
    return self.sex == StudentSexMale ? @"Male" : @"Female";
}

- (NSString *)getYearOfBirthStringRepresentation {
    return [self.dateFormatter stringFromDate:self.birthDate];
}

- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"YYYY"];
    }
    return _dateFormatter;
}

@end
