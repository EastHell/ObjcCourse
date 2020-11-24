//
//  ASGoverment.m
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASGoverment.h"

NSString * const ASGovermentTaxLevelDidChangeNotification = @"ASGovermentTaxLevelDidChangeNotification";
NSString * const ASGovermentSalaryDidChangeNotification = @"ASGovermentSalaryDidChangeNotification";
NSString * const ASGovermentPensionDidChangeNotification = @"ASGovermentPensionDidChangeNotification";
NSString * const ASGovermentAveragePriceDidChangeNotification = @"ASGovermentAveragePriceDidChangeNotification";

NSString * const ASGovermentTaxLevelUserInfoKey = @"ASGovermentTaxLevelUserInfoKey";
NSString * const ASGovermentSalaryUserInfoKey = @"ASGovermentSalaryUserInfoKey";
NSString * const ASGovermentPensionUserInfoKey = @"ASGovermentPensionUserInfoKey";
NSString * const ASGovermentAveragePriceUserInfoKey = @"ASGovermentAveragePriceUserInfoKey";

@implementation ASGoverment

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taxLevel = 5.f;
        _salary = 1000.f;
        _pension = 500.f;
        _averagePrice = 10.f;
    }
    return self;
}

- (void)setTaxLevel:(CGFloat)taxLevel {
    _taxLevel = taxLevel;
    
    NSDictionary *dictionary = @{ASGovermentTaxLevelUserInfoKey : @(taxLevel)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentTaxLevelDidChangeNotification object:nil userInfo:dictionary];
}

- (void)setSalary:(CGFloat)salary {
    _salary = salary;
    
    NSDictionary *dictionary = @{ASGovermentSalaryUserInfoKey : @(salary)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentSalaryDidChangeNotification object:nil userInfo:dictionary];
}

- (void)setPension:(CGFloat)pension {
    _pension = pension;
    
    NSDictionary *dictionary = @{ASGovermentPensionUserInfoKey : @(pension)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentPensionDidChangeNotification object:nil userInfo:dictionary];
}

- (void)setAveragePrice:(CGFloat)averagePrice {
    _averagePrice = averagePrice;
    
    NSDictionary *dictionary = @{ASGovermentAveragePriceUserInfoKey : @(averagePrice)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentAveragePriceDidChangeNotification object:nil userInfo:dictionary];
}

@end
