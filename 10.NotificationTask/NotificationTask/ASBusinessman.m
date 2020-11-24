//
//  ASBusinessman.m
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASBusinessman.h"
#import "ASGoverment.h"
#import <UIKit/UIKit.h>

@implementation ASBusinessman

#pragma mark - Initializations

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(taxLevelChangedNotification:) name:ASGovermentTaxLevelDidChangeNotification object:nil];
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

- (void)taxLevelChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentTaxLevelUserInfoKey];
    
    CGFloat taxLevel = [value floatValue];
    
    if (taxLevel > self.taxLevel) {
        NSLog(@"Businessmans are NOT happy");
    } else {
        NSLog(@"Businessmans are happy");
    }
    
    self.taxLevel = taxLevel;
}

- (void)averagePriceChangedNotification:(NSNotification *) notification {
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    
    CGFloat averagePrice = [value floatValue];
    
    if (averagePrice >= self.averagePrice) {
        NSLog(@"Businessmans are NOT happy");
    } else {
        NSLog(@"Businessmans are happy");
    }
    
    self.averagePrice = averagePrice;
}

- (void)applicationDidEnterBackground {
    NSLog(@"Businessmans is Background");
}

@end
