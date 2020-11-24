//
//  ASSwimmer.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASSwimmer.h"

@implementation ASSwimmer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Swimmer";
        self.height = 1.6f;
        self.weight = 60.f;
        self.sex = @"Woman";
    }
    return self;
}

- (void)move {
    NSLog(@"Swimmer name: %@ swim", self.name);
}

@end
