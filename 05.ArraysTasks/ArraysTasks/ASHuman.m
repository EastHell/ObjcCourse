//
//  ASHuman.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASHuman.h"

@implementation ASHuman

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Human";
        self.height = 1.3f;
        self.weight = 70.f;
        self.sex = @"It's a trap!";
    }
    return self;
}

- (void)move {
    NSLog(@"Human name: %@ move", self.name);
}

@end
