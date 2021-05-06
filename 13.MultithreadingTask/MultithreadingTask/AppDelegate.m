//
//  AppDelegate.m
//  MultithreadingTask
//
//  Created by Aleksandr on 01/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"
#import "ASSecondStudent.h"
#import "ASExceptionsConstants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark - Level_1 and Level_2 and Level_3
    
    ASStudent *student1 = [[ASStudent alloc] initWithName:@"Vasya"];
    ASStudent *student2 = [[ASStudent alloc] initWithName:@"Kolya"];
    ASStudent *student3 = [[ASStudent alloc] initWithName:@"Petya"];
    ASStudent *student4 = [[ASStudent alloc] initWithName:@"Nastya"];
    ASStudent *student5 = [[ASStudent alloc] initWithName:@"Olya"];

    @try {
        [student1 guessAnswerWithValue:60 min:20 max:90 completion:^{
            NSLog(@"Student %@ guessed", student1.name);
        }];
        [student2 guessAnswerWithValue:60 min:20 max:90 completion:^{
            NSLog(@"Student %@ guessed", student2.name);
        }];
        [student3 guessAnswerWithValue:60 min:20 max:90 completion:^{
            NSLog(@"Student %@ guessed", student3.name);
        }];
        [student4 guessAnswerWithValue:60 min:20 max:90 completion:^{
            NSLog(@"Student %@ guessed", student4.name);
        }];
        [student5 guessAnswerWithValue:60 min:20 max:90 completion:^{
            NSLog(@"Student %@ guessed", student5.name);
        }];
    } @catch (NSException *exception) {
        if (exception.name == ASWrongRangeException) {
            NSLog(@"VSE PROPALO %@", exception.reason);
        } else {
            NSLog(@"VSE PROPALO NO NEPONYATNO POOCHEMU");
        }
    } @finally {
        NSLog(@"CHE VASHE PROIZOSHLO?");
    }
    
#pragma mark - Level_4
    
    ASSecondStudent *secStudent = [[ASSecondStudent alloc] initWithName:@"ANTONINA PAVLOVNA"];
    @try {
        [secStudent guessAnswerWithValue:60 min:20 max:100 completion:^{
            NSLog(@"Student %@ guessed", secStudent.name);
        }];
    } @catch (NSException *exception) {
        
        if (exception.name == ASWrongRangeException) {
            NSLog(@"VSE PROPALO %@", exception.reason);
        } else {
            NSLog(@"VSE PROPALO NO NEPONYATNO POOCHEMU");
        }
    } @finally {        
        NSLog(@"CHE VASHE PROIZOSHLO?");
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
