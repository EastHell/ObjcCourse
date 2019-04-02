//
//  ASStudent.m
//  MultithreadingTask
//
//  Created by Aleksandr on 01/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASStudent.h"
#import <QuartzCore/CoreAnimation.h>
#import "ASExceptionsConstants.h"

@implementation ASStudent

+ (dispatch_queue_t)createQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("ASThreadQueueLabel", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

- (instancetype)initWithName:(NSString *)name
{
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
    dispatch_async([ASStudent createQueue], ^{
        while (true) {
            number = min + arc4random_uniform((uint32_t)(max - min + 1));
            if (number == intValue) {
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });    
}

@end
