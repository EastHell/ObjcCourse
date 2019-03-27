//
//  AppDelegate.m
//  NotificationTask
//
//  Created by Aleksandr on 26/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASGoverment.h"
#import "ASDoctor.h"
#import "ASPensioner.h"
#import "ASBusinessman.h"
#import "ASAnalog.h"

@interface AppDelegate ()
@property (strong, nonatomic) ASGoverment *goverment;
@property (strong, nonatomic) ASDoctor *doctor;
@property (strong, nonatomic) ASPensioner *pensioner;
@property (strong, nonatomic) ASBusinessman *businessman;
@property (strong, nonatomic) ASAnalog *analog;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.goverment = [[ASGoverment alloc] init];
    self.doctor = [[ASDoctor alloc] init];
    self.pensioner = [[ASPensioner alloc] init];
    self.businessman = [[ASBusinessman alloc] init];
    self.analog = [[ASAnalog alloc] init];
    
    self.doctor.averagePrice = self.pensioner.averagePrice = self.businessman.averagePrice = self.goverment.averagePrice;
    self.doctor.salary = self.goverment.salary;
    self.pensioner.pension = self.goverment.pension;
    self.businessman.taxLevel = self.goverment.taxLevel;
    
    self.goverment.taxLevel = 5.5f;
    self.goverment.salary = 1100.f;
    self.goverment.averagePrice = 15.f;
    self.goverment.pension = 550.f;
    
    self.goverment.taxLevel = 5.4f;
    self.goverment.salary = 1090.f;
    self.goverment.averagePrice = 14.f;
    self.goverment.pension = 540.f;
    
    NSLog(@"APPDELEGATTEapplicationDidFinishLaunching");
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"APPDELEGATTEapplicationWillResignActive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"APPDELEGATTEapplicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"APPDELEGATTEapplicationWillEnterForeground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"APPDELEGATTEapplicationDidBecomeActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"APPDELEGATTEapplicationWillTerminate");
}


@end
