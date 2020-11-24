//
//  ASAnalog.m
//  NotificationTask
//
//  Created by Aleksandr on 27/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ASAnalog.h"
#import <UIKit/UIKit.h>

@implementation ASAnalog

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(applicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [nc addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [nc addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [nc addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        [nc addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [nc addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)applicationDidFinishLaunching {
    NSLog(@"ANALOGapplicationDidFinishLaunching");
}

- (void)applicationWillResignActive {
    NSLog(@"ANALOGapplicationWillResignActive");
}

- (void)applicationDidEnterBackground {
    NSLog(@"ANALOGapplicationDidEnterBackground");
}

- (void)applicationWillEnterForeground {
    NSLog(@"ANALOGapplicationWillEnterForeground");
}

- (void)applicationDidBecomeActive {
    NSLog(@"ANALOGapplicationDidBecomeActive");
}

- (void)applicationWillTerminate {
    NSLog(@"ANALOGapplicationWillTerminate");
}

@end
