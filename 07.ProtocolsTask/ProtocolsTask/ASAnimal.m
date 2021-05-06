//
//  ASAnimal.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASAnimal.h"

@implementation ASAnimal

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nubersOfLegs = 1;
        self.movingSpeed = 2;
    }
    return self;
}

- (void)move {
    NSLog(@"Animal moves with %ld speed", self.movingSpeed);
}

@end
