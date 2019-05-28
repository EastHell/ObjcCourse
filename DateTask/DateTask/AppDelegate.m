//
//  AppDelegate.m
//  DateTask
//
//  Created by Aleksandr on 06/04/2019.
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
    
    NSMutableArray<ASStudent *> *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 30; i++) {
        ASStudent *student = [ASStudent new];
        
        //Получаем текущий год
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *today = [NSDate date];
        NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear fromDate:today];
        
        //Создаем дату из компонент
        NSDateComponents *component = [NSDateComponents new];
        [component setYear:todayComponents.year - 16 - arc4random_uniform(35)];
        [component setMonth:arc4random_uniform(12) + 1];
        [component setDay:arc4random_uniform(31)+1];
        
        //Присваиваем дату и добавляем студента в массив
        student.dateOfBirth = [calendar dateFromComponents:component];
        [array addObject:student];
    }
    
    NSDateFormatter *dateFromatter = [NSDateFormatter new];
    [dateFromatter setDateFormat:@"dd.MM.yyyy"];
    
    for (ASStudent *student in array) {
        NSLog(@"%@", [dateFromatter stringFromDate:student.dateOfBirth]);
    }
    
#pragma mark - Level_2
    
    [array sortUsingComparator:^NSComparisonResult(ASStudent *obj1, ASStudent *obj2) {
        return [obj1.dateOfBirth compare:obj2.dateOfBirth];
    }];
    
    NSArray *names = @[@"Kolya", @"Petya", @"Denis", @"Anton", @"Pavel", @"Sergey", @"Vasya"];
    NSArray *lastNames = @[@"Petrov", @"Sidorov", @"Ivanov", @"Vasilev", @"Pavlov", @"Kostyn", @"Danilov"];
    
    for (ASStudent *student in array) {
        student.name = [names objectAtIndex:arc4random_uniform((uint32_t)names.count)];
        student.lastName = [lastNames objectAtIndex:arc4random_uniform((uint32_t)lastNames.count)];
        NSLog(@"%@", student);
    }
    
#pragma mark - Level_3
    
    //Получаем текущую дату
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        for (ASStudent *student in array) {
            NSDateComponents *birthDayComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:student.dateOfBirth];
            if (birthDayComponents.month == todayComponents.month && birthDayComponents.day == todayComponents.day) {
                NSLog(@"Happy birth day %@\r\r\r%@", student, todayComponents);
            }
        }
        [todayComponents setDay:todayComponents.day + 1];
    }];
    NSDateComponents *difference = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:[array objectAtIndex:0].dateOfBirth toDate:[array objectAtIndex:array.count - 1].dateOfBirth options:0];
    
    NSLog(@"Difference between students: years = %ld, month = %ld, weeks = %ld, days = %ld", difference.year, difference.month, difference.weekday, difference.day);
    
#pragma mark - Level_4
    
    [dateFromatter setDateFormat:@"EEEE"];
    for (NSInteger i = 0; i < 12; i++) {
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:today];
        [dateComponents setMonth:i+1];
        [dateComponents setDay:1];
        NSDate *tmp = [calendar dateFromComponents:dateComponents];
        NSLog(@"%@", [dateFromatter stringFromDate:tmp]);
    }
    
    [dateFromatter setDateFormat:@"dd.MM.yyyy"];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:today];
    dateComponents.month = 1;
    dateComponents.weekday = 1;
    dateComponents.weekdayOrdinal = 1;
    NSDate *sunday = [calendar dateFromComponents:dateComponents];
    while (dateComponents.year == 2019) {
        NSLog(@"%@", [dateFromatter stringFromDate:sunday]);
        sunday = [NSDate dateWithTimeInterval:60*60*24*7 sinceDate:sunday];
        dateComponents = [calendar components:NSCalendarUnitYear fromDate:sunday];
    }
    
    [dateFromatter setDateFormat:@"MMMM in YYYY"];
    
    dateComponents = [calendar components:NSCalendarUnitYear fromDate:today];
    dateComponents.month = 1;
    dateComponents.day = 1;
    NSDate *date = [calendar dateFromComponents:dateComponents];
    while (dateComponents.year == 2019) {
        NSInteger lastMonth = [calendar component:NSCalendarUnitMonth fromDate:date];
        NSInteger workDaysCounter = 0;
        NSLog(@"%@", [dateFromatter stringFromDate:date]);
        while (lastMonth == [calendar component:NSCalendarUnitMonth fromDate:date]) {
            if (([calendar component:NSCalendarUnitWeekday fromDate:date] != 1) && ([calendar component:NSCalendarUnitWeekday fromDate:date] != 7)) {
                workDaysCounter += 1;
            }
            date = [NSDate dateWithTimeInterval:60*60*24 sinceDate:date];
            dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitWeekday |NSCalendarUnitMonth
                                         fromDate:date];
        }
        NSLog(@"has %ld workdays", workDaysCounter);
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
