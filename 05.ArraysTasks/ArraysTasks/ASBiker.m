//
//  ASBiker.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASBiker.h"

@implementation ASBiker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Biker";
        self.height = 1.65f;
        self.weight = 65.f;
        self.sex = @"futanari";
    }
    return self;
}

- (void)move {
    NSLog(@"Biker name: %@ ride", self.name);
}

@end
