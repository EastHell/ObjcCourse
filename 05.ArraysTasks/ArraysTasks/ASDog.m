//
//  ASDog.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASDog.h"

@implementation ASDog

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nubersOfLegs = 4;
        self.movingSpeed = 20;
    }
    return self;
}

- (void)move {
    NSLog(@"Dog run with %ld speed", self.movingSpeed);
}

@end
