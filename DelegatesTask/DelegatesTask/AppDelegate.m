//
//  AppDelegate.m
//  DelegatesTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASPatient.h"
#import "ASDoctor.h"
#import "ASFriend.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ASPatient *patient1 = [[ASPatient alloc] init];
    ASPatient *patient2 = [[ASPatient alloc] init];
    ASPatient *patient3 = [[ASPatient alloc] init];
    ASPatient *patient4 = [[ASPatient alloc] init];
    ASPatient *patient5 = [[ASPatient alloc] init];
    ASDoctor *doctor = [[ASDoctor alloc] init];
    ASFriend *friend1 = [[ASFriend alloc] init];
    ASFriend *friend2 = [[ASFriend alloc] init];
    
    NSArray *patientsArray = @[patient1, patient2, patient3, patient4, patient5];
    
    [patientsArray enumerateObjectsUsingBlock:^(ASPatient *obj, NSUInteger idx, BOOL *stop) {
        obj.name = [NSString stringWithFormat:@"Vasya%ld", idx];
        obj.temperature = 38.f;
        obj.cought = idx % 2;
        obj.hurtIn = idx % 4;
    }];
    
    friend1.name = @"Friend Kolya";
    friend2.name = @"Friend Danil";
    
    for (ASPatient *obj in patientsArray) {
        obj.delegate = doctor;
        [obj feelWorse];
        
        obj.delegate = friend1;
        [obj feelWorse];
        
        obj.delegate = friend2;
        [obj feelWorse];
    }
    
    [doctor printRaport];
    
    for (ASPatient *obj in patientsArray) {
        if (obj.doctorsRate == 0) {
            obj.delegate = friend1;
        }
        [obj feelWorse];
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
