//
//  ASSecondStudent.m
//  MultithreadingTask
//
//  Created by Aleksandr on 01/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASSecondStudent.h"
#import "ASExceptionsConstants.h"

@implementation ASSecondStudent

+ (NSOperationQueue *)newQueue {
    __block NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)guessAnswerWithValue:(NSInteger)intValue min:(NSInteger)min max:(NSInteger)max completion:(dispatch_block_t)completion {
    if (min > max) {
        NSException *myException = [NSException exceptionWithName:ASWrongRangeException
                                                           reason:@"MinValue > MinValue"
                                                         userInfo:nil];
        @throw myException;
    }    
    __block NSInteger number;
    NSBlockOperation *theOp = [NSBlockOperation blockOperationWithBlock:^{
        while (true) {
            number = min + arc4random_uniform((uint32_t)(max - min + 1));
            if (number == intValue) {
                break;
            }
        }
        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:completion]];
    }];
    [[ASSecondStudent newQueue] addOperation:theOp];
}

@end
