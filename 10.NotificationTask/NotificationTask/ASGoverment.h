//
//  ASGoverment.h
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const ASGovermentTaxLevelDidChangeNotification;
extern NSString * const ASGovermentSalaryDidChangeNotification;
extern NSString * const ASGovermentPensionDidChangeNotification;
extern NSString * const ASGovermentAveragePriceDidChangeNotification;

extern NSString * const ASGovermentTaxLevelUserInfoKey;
extern NSString * const ASGovermentSalaryUserInfoKey;
extern NSString * const ASGovermentPensionUserInfoKey;
extern NSString * const ASGovermentAveragePriceUserInfoKey;

@interface ASGoverment : NSObject

@property (assign, nonatomic) CGFloat taxLevel;
@property (assign, nonatomic) CGFloat salary;
@property (assign, nonatomic) CGFloat pension;
@property (assign, nonatomic) CGFloat averagePrice;

@end

NS_ASSUME_NONNULL_END
