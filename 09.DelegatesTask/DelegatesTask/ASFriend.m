//
//  ASFriend.m
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASFriend.h"

@implementation ASFriend

- (void)patientfeelWorse:(ASPatient *)patient {
    NSLog(@"%@ I tak soidet %@", self.name, patient.name);
}

@end
