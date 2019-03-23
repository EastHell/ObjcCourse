//
//  ASRunner.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASRunner.h"

@implementation ASRunner

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Runner";
        self.height = 1.9f;
        self.weight = 40.f;
        self.sex = @"male";
    }
    return self;
}

- (void)move {
    NSLog(@"Runner name: %@ run", self.name);
}

- (void)run {
    NSLog(@"Runner run");
}

- (NSString *)whatIsYourSpeed{
    return [NSString stringWithFormat:@"Runner speed is %ld", self.speed];
}

@end
