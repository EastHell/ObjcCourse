//
//  ASPatient.m
//  BlocksTask
//
//  Created by Aleksandr on 29/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASPatient.h"

@implementation ASPatient

- (instancetype)init:(BOOL (^)(ASPatient *))block {
    self = [super init];
    if (self) {
        [self performSelector:@selector(feelBad:)
                   withObject:block
                   afterDelay:arc4random_uniform(11)+5];
    }
    return self;
}

- (void)feelBad:(BOOL (^)(ASPatient *))heal {
    NSLog(@"Patient feels bad man");
    if (heal(self)) {
        NSLog(@"Patient feels better");
    } else {
        NSLog(@"Patient sill feeling bad");
    }
}

- (void)dealloc {
    NSLog(@"Patient is deallocatted");
}

@end
