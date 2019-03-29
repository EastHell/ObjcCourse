//
//  ASPatient.h
//  BlocksTask
//
//  Created by Aleksandr on 29/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASPatient : NSObject

@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) BOOL cough;

- (instancetype) init:(BOOL (^)(ASPatient *))block;
- (void)feelBad:(BOOL (^)(ASPatient *))heal;

@end

NS_ASSUME_NONNULL_END
