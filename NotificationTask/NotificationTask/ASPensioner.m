//
//  ASPensioner.m
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASPensioner.h"
#import "ASGoverment.h"
#import <UIKit/UIKit.h>

@implementation ASPensioner

#pragma mark - Initializations

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(pensionChangedNotification:) name:ASGovermentPensionDidChangeNotification object:nil];
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

- (void)pensionChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentPensionUserInfoKey];
    
    CGFloat pension = [value floatValue];
    
    if (pension <= self.pension) {
        NSLog(@"Pensioners are NOT happy");
    } else {
        NSLog(@"Pensioners are happy");
    }
    
    self.pension = pension;
}

- (void)averagePriceChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (averagePrice >= self.averagePrice) {
        NSLog(@"Pensioners are NOT happy");
    } else {
        NSLog(@"Pensioners are happy");
    }
    
    self.averagePrice = averagePrice;
}

- (void)applicationDidEnterBackground {
    NSLog(@"Pensioners is Background");
}

@end
