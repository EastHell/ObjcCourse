//
//  AppDelegate.m
//  BitwiseTask
//
//  Created by Aleksandr on 05/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark - Level_1
    
    NSMutableArray *studentsArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        ASStudent *student = [[ASStudent alloc] init];
        
        student.subjectType = (arc4random_uniform(2) ? ASStudentSubjectTypeBiology : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypeMath : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypeDevelopment : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypeEngineering : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypeArt : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypePsychology : 0) |
        (arc4random_uniform(2) ? ASStudentSubjectTypeAnatomy : 0);
        NSLog(@"%@", student);
        
        [studentsArray addObject:student];
    }
    
#pragma mark - Level_2
    
    NSMutableArray *technicalStudentsArray = [NSMutableArray array];
    NSMutableArray *humanitarianStudentsArray = [NSMutableArray array];
    
    NSInteger mathLearningStudentsCounter = 0;
    
    for (ASStudent *student in studentsArray) {
        if (student.subjectType & (ASStudentSubjectTypeMath | ASStudentSubjectTypeDevelopment | ASStudentSubjectTypeEngineering | ASStudentSubjectTypeArt)) {
            [technicalStudentsArray addObject:student];
        }
        if (student.subjectType & (ASStudentSubjectTypeBiology | ASStudentSubjectTypePsychology | ASStudentSubjectTypeAnatomy)) {
            [humanitarianStudentsArray addObject:student];
        }
        if (student.subjectType & ASStudentSubjectTypeMath) {
            mathLearningStudentsCounter += 1;
        }
    }
    
    NSLog(@"\r\rTecnical students: %@", technicalStudentsArray);
    NSLog(@"\r\rHumanitarian students: %@", humanitarianStudentsArray);
    NSLog(@"\r\r%ld", mathLearningStudentsCounter);
    
#pragma mark - Level_3
    
    for (ASStudent *student in humanitarianStudentsArray) {
        if (student.subjectType & ASStudentSubjectTypeBiology) {
            student.subjectType = student.subjectType ^ ASStudentSubjectTypeBiology;
        }
    }
    
    NSLog(@"\r\rHumanitarian students without biology: %@", humanitarianStudentsArray);
    
#pragma mark - Level_4
    
    NSInteger intValue = arc4random_uniform(UINT32_MAX);
    NSLog(@"\r\rValue: %ld", intValue);
    NSMutableString *binaryRepresentation = [NSMutableString string];
    
    while (intValue != 0) {
        if (intValue & 1) {
            [binaryRepresentation insertString:@"1" atIndex:0];
        } else {
            [binaryRepresentation insertString:@"0" atIndex:0];
        }
        intValue = intValue >> 1;
    }
    
    NSLog(@"\r\rBinary representation: %@", binaryRepresentation);
    
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
