//
//  ASBird.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASBird.h"

@implementation ASBird

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nubersOfLegs = 2;
        self.movingSpeed = 50;
    }
    return self;
}

- (void)move {
    NSLog(@"Bird fly with %ld speed", self.movingSpeed);
}

- (void)swim {
    NSLog(@"Bird swim");
}

@end
