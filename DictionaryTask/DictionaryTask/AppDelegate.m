//
//  AppDelegate.m
//  DictionaryTask
//
//  Created by Aleksandr on 24/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
    
    NSArray *studentsArray = [NSArray arrayWithObjects:student1, student2, student3, student4, student5, student6, student7, student8, student9, student10, nil];
    
    for (NSInteger i = 0; i < studentsArray.count; i++) {
        ASStudent *obj = [studentsArray objectAtIndex:i];
        obj.name = [NSString stringWithFormat:@"student%ld_name", i+1];
        obj.lastName = [NSString stringWithFormat:@"student%ld_lastName", i+1];
        obj.greeting = [NSString stringWithFormat:@"student%ld is greeting you!", i+1];
    }
    
    NSDictionary *classJournal = [NSDictionary
                                  dictionaryWithObjectsAndKeys:
                                  student1, [NSString stringWithFormat:@"%@ %@", student1.lastName, student1.name],
                                  student2, [NSString stringWithFormat:@"%@ %@", student2.lastName, student2.name],
                                  student3, [NSString stringWithFormat:@"%@ %@", student3.lastName, student3.name],
                                  student4, [NSString stringWithFormat:@"%@ %@", student4.lastName, student4.name],
                                  student5, [NSString stringWithFormat:@"%@ %@", student5.lastName, student5.name],
                                  student6, [NSString stringWithFormat:@"%@ %@", student6.lastName, student6.name],
                                  student7, [NSString stringWithFormat:@"%@ %@", student7.lastName, student7.name],
                                  student8, [NSString stringWithFormat:@"%@ %@", student8.lastName, student8.name],
                                  student9, [NSString stringWithFormat:@"%@ %@", student9.lastName, student9.name],
                                  student10, [NSString stringWithFormat:@"%@ %@", student10.lastName, student10.name],
                                  nil];
    
    NSLog(@"%@", classJournal);
    
    for (id obj in [[classJournal allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]) {
        NSString *key = obj;
        ASStudent *student = [classJournal objectForKey:key];
        NSLog(@"%@, %@", key, student.greeting);
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
