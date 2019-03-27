//
//  ASDoctor.m
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASDoctor.h"
#import "ASGoverment.h"
#import <UIKit/UIKit.h>

@implementation ASDoctor

#pragma mark - Initializations

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(salaryChangedNotification:) name:ASGovermentSalaryDidChangeNotification object:nil];
        [nc addObserver:self selector:@selector(averagePriceChangedNotification:) name:ASGovermentAveragePriceDidChangeNotification object:nil];
        [nc addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)salaryChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentSalaryUserInfoKey];
    
    CGFloat salary = [value floatValue];
    
    if (salary <= self.salary) {
        NSLog(@"Doctors are NOT happy");
    } else {
        NSLog(@"Doctors are happy");
    }
    
    self.salary = salary;
}

- (void)averagePriceChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (averagePrice >= self.averagePrice) {
        NSLog(@"Doctors are NOT happy");
    } else {
        NSLog(@"Doctors are happy");
    }
    
    self.averagePrice = averagePrice;
}

- (void)applicationDidEnterBackground {
    NSLog(@"Doctors is Background");
}

@end
