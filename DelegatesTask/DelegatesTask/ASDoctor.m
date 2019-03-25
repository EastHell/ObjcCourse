//
//  ASDoctor.m
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASDoctor.h"

@interface ASDoctor()

@property (strong, nonatomic) NSMutableString *hurtLegNames;
@property (strong, nonatomic) NSMutableString *hurtHeadsNames;
@property (strong, nonatomic) NSMutableString *hurtBodysNames;
@property (strong, nonatomic) NSMutableString *hurtHandsNames;

@end

@implementation ASDoctor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hurtLegNames = [NSMutableString string];
        _hurtHeadsNames = [NSMutableString string];
        _hurtBodysNames = [NSMutableString string];
        _hurtHandsNames = [NSMutableString string];
    }
    return self;
}

- (void)patientfeelWorse:(ASPatient *)patient {
    if (patient.cought == YES) {
        NSLog(@"Patient %@ take a pill", patient.name);
    }
    if (patient.temperature >= 37) {
        NSLog(@"Patient %@ make a shot", patient.name);
    }
    NSLog(@"Patinent %@ feels better", patient.name);
    
    switch (patient.hurtIn) {
        case leg:
            [self addName:patient.name toString:self.hurtLegNames];
            break;
        case hand:
            [self addName:patient.name toString:self.hurtHandsNames];
            break;
        case head:
            [self addName:patient.name toString:self.hurtHeadsNames];
            break;
        case body:
            [self addName:patient.name toString:self.hurtBodysNames];
            break;
        default:
            break;
    }
}

- (void)addName:(NSString *)name toString:(NSMutableString *)string {
    if (string.length == 0) {
        [string appendString:name];
    } else {
        [string appendFormat:@", %@", name];
    }
}

- (void)printRaport {
    NSLog(@"Patients with hurt in legs: %@\nPatinents with hurt in hands: %@\nPatients with hurt in heads: %@\nPatients with hurt in bodys: %@", self.hurtLegNames, self.hurtHandsNames, self.hurtHeadsNames, self.hurtBodysNames);
}

@end
