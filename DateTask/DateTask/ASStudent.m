//
//  ASStudent.m
//  DateTask
//
//  Created by Aleksandr on 06/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (NSString *)description
{
    NSDateFormatter *dateFromatter = [NSDateFormatter new];
    [dateFromatter setDateFormat:@"dd.MM.yyyy"];
    return [NSString stringWithFormat:@"%@ %@ date of birth %@", self.name, self.lastName, [dateFromatter stringFromDate:self.dateOfBirth]];
}

@end
