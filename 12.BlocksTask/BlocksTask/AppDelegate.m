//
//  AppDelegate.m
//  BlocksTask
//
//  Created by Aleksandr on 29/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"
#import "ASPatient.h"

typedef void (^VoidBlock)(NSString *);

@interface AppDelegate ()

@property (strong, nonatomic) NSArray *patientsArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark - Level_1
    
    void (^block)(void) = ^() {
        NSLog(@"block1");
    };
    
    block();
    
    void (^blockWithStringParameter)(NSString *) = ^(NSString *string) {
        NSLog(@"%@", string);
    };
    
    blockWithStringParameter(@"blockWithStringParameter");
    
    VoidBlock blockWithStringParameter2 = ^void(NSString *string) {
        NSLog(@"Block2: %@", string);
    };
    
    blockWithStringParameter2(@"string for block 2");
    
    [self methodWithBlock:blockWithStringParameter2];
    
#pragma mark - Level_2
    
    ASStudent *student1 = [[ASStudent alloc] init];
    ASStudent *student2 = [[ASStudent alloc] init];
    ASStudent *student3 = [[ASStudent alloc] init];
    ASStudent *student4 = [[ASStudent alloc] init];
    ASStudent *student5 = [[ASStudent alloc] init];
    ASStudent *student6 = [[ASStudent alloc] init];
    ASStudent *student7 = [[ASStudent alloc] init];
    ASStudent *student8 = [[ASStudent alloc] init];
    ASStudent *student9 = [[ASStudent alloc] init];
    ASStudent *student10 = [[ASStudent alloc] init];
    
    NSArray *students = @[student1, student2, student3, student4, student5, student6, student7, student8, student9, student10];
    
    [students enumerateObjectsUsingBlock:^(ASStudent *obj, NSUInteger idx, BOOL *stop) {
        obj.name = [NSString stringWithFormat:@"student%ld", idx+1];
        obj.lastName = [NSString stringWithFormat:@"student%ld_lastName%ld", idx+1, idx+1];
    }];
    
    student10.lastName = @"student1_lastName1";
    student9.lastName = @"student2_lastName2";
    
    students = [students sortedArrayUsingComparator:^NSComparisonResult(ASStudent *obj1, ASStudent *obj2) {
        NSComparisonResult res = [obj2.lastName caseInsensitiveCompare:obj1.lastName];
        if (res == NSOrderedSame) {
            return [obj2.name caseInsensitiveCompare:obj1.name];
        }
        return res;
    }];
    
    [students enumerateObjectsUsingBlock:^(ASStudent *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@", obj.name);
    }];
    
#pragma mark - Level_3
    
    ASPatient *patient = [[ASPatient alloc] init];
    patient.temperature = 37.7f;
    patient.cough = YES;
    
    [patient feelBad:^BOOL(ASPatient *obj) {
        if (obj.cough) {
            NSLog(@"patient take a pill");
        }
        if (obj.temperature >= 37) {
            NSLog(@"patient make a shot");
        }
        return arc4random_uniform(2);
    }];
    
#pragma mark - Level_4
    
    BOOL (^heal)(ASPatient *) = ^BOOL(ASPatient *obj) {
        if (obj.cough) {
            NSLog(@"patient take a pill");
        }
        if (obj.temperature >= 37) {
            NSLog(@"patient make a shot");
        }
        return arc4random_uniform(2);
    };
    
    ASPatient *patient1 = [[ASPatient alloc] init:heal];
    ASPatient *patient2 = [[ASPatient alloc] init:heal];
    ASPatient *patient3 = [[ASPatient alloc] init:heal];
    
    self.patientsArray = @[patient1, patient2, patient3];
    [self.patientsArray enumerateObjectsUsingBlock:^(ASPatient *obj, NSUInteger idx, BOOL *stop) {
        obj.temperature = arc4random_uniform(2)+36.6f;
        obj.cough = arc4random_uniform(2);
    }];
    
    return YES;
}

- (void)methodWithBlock:(VoidBlock)block {
    block(@"string from method");
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
