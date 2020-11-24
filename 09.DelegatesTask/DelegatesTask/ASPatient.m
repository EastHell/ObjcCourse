//
//  ASPatient.m
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASPatient.h"

@implementation ASPatient

- (void)feelWorse {
    [self.delegate patientfeelWorse:self];
    self.doctorsRate = arc4random_uniform(2);
}

@end
