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

- (void)jump {
    NSLog(@"Dog jump");
}

- (void)writeJumpsCount {
    NSLog(@"Dog jumps count %ld", self.jumpsCount);
}

- (void)run {
    NSLog(@"Dog run");
}

- (void)swim {
    NSLog(@"Dog swim");
}

- (NSString *)sayFavoriteSwimStyle {
    return self.favoriteSwimStyle;
}

@end
