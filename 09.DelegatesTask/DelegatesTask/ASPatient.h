//
//  ASPatient.h
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef enum {
    leg,
    head,
    hand,
    body
} bodyPart;

NS_ASSUME_NONNULL_BEGIN

@class ASPatient;
@protocol ASPatientDelegate <NSObject>

- (void)patientfeelWorse:(ASPatient *)patient;

@end

@interface ASPatient : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) BOOL cought;
@property (assign, nonatomic) bodyPart hurtIn;
@property (assign, nonatomic) NSInteger doctorsRate;
@property (weak, nonatomic) id <ASPatientDelegate> delegate;

- (void)feelWorse;

@end

NS_ASSUME_NONNULL_END
