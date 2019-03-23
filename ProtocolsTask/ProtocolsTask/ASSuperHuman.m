//
//  ASSuperHuman.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASSuperHuman.h"

@implementation ASSuperHuman

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Flash";
        self.height = 1.3f;
        self.weight = 16.f;
        self.sex = @"undefine";
        self.pantsColor = @"Red";
        self.superPower = @"SuperSpeed";
    }
    return self;
}

- (void)move {
    [super move];
    NSLog(@"SuperHuman name: %@ move", self.name);
}

- (void)jump {
    NSLog(@"SuperHuman jump");
}

@end
