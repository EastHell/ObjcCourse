//
//  AppDelegate.m
//  ProtocolsTask
//
//  Created by Aleksandr on 23/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASJumpers.h"
#import "ASSwimmers.h"
#import "ASRunners.h"
#import "ASSwimmer.h"
#import "ASSuperHuman.h"
#import "ASRunner.h"
#import "ASDog.h"
#import "ASBird.h"
#import "ASBiker.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ASBiker *biker = [[ASBiker alloc] init];
    ASBird *bird = [[ASBird alloc] init];
    ASDog *dog = [[ASDog alloc] init];
    ASRunner *runner = [[ASRunner alloc] init];
    ASSuperHuman *superHuman = [[ASSuperHuman alloc] init];
    ASSwimmer *swimmer = [[ASSwimmer alloc] init];
    
    bird.favoriteSwimStyle = @"Brass";
    
    dog.jumpHeight = 2;
    dog.jumpsCount = 30;
    dog.speed = 50;
    dog.favoriteSwimStyle = @"Doggy";
    dog.swimstylesKnow = 1;
    
    runner.speed = 15;
    runner.favoriteRunStyle = maraphone;
    
    superHuman.jumpHeight = 5000;
    
    swimmer.favoriteSwimStyle = @"Free";
    swimmer.swimstylesKnow = 5;
    
    NSArray *array = [NSArray arrayWithObjects:biker, bird, dog, runner, superHuman, swimmer, nil];
    
    for (id element in array) {
        if ([element conformsToProtocol:@protocol(ASJumpers)]) {
            id <ASJumpers> jumperFromArray = element;
            if ([jumperFromArray respondsToSelector:@selector(jumpsCount)] && [jumperFromArray respondsToSelector:@selector(writeJumpsCount)]) {
                [jumperFromArray writeJumpsCount];
            }
            [jumperFromArray jump];
            NSLog(@"Jump height: %ld", jumperFromArray.jumpHeight);
        }
        if ([element conformsToProtocol:@protocol(ASRunners)]) {
            id <ASRunners> runnerFromArray = element;
            [runnerFromArray run];
        }
        if ([element conformsToProtocol:@protocol(ASSwimmers)]) {
            id <ASSwimmers> swimmerFromArray = element;
            [swimmerFromArray swim];
        }
        if (![element conformsToProtocol:@protocol(ASJumpers)] && ![element conformsToProtocol:@protocol(ASRunners)] && ![element conformsToProtocol:@protocol(ASSwimmers)]) {
            NSLog(@"Lazy boy");
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
