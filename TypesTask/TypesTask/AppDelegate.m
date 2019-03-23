//
//  AppDelegate.m
//  TypesTask
//
//  Created by Aleksandr on 22/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Немного усложнил задачку квадрат 3х3 не в центрее поля 10х10, а
    //в случайном месте поля 10х10
    const NSInteger FIELD_SIDE_LENGTH = 10; //Сторона поля
    const NSInteger KUBE_SIDE_LENGTH = 3; //Сторона куба
    const NSInteger MAX_DOTS_COUNT = 100; //Максимальное возможное кол-во точек
    CGRect kube = CGRectMake(arc4random_uniform(FIELD_SIDE_LENGTH - KUBE_SIDE_LENGTH + 1), arc4random_uniform(FIELD_SIDE_LENGTH - KUBE_SIDE_LENGTH + 1), KUBE_SIDE_LENGTH, KUBE_SIDE_LENGTH);
    NSInteger dotsCount = arc4random_uniform(MAX_DOTS_COUNT+1);
    NSMutableArray *dotsArray = [NSMutableArray arrayWithCapacity:dotsCount];
    
    //Заполняем массив точками
    for (NSInteger i = 0; i < dotsCount; i++) {
        CGPoint point = CGPointMake(arc4random_uniform(FIELD_SIDE_LENGTH+1), arc4random_uniform(FIELD_SIDE_LENGTH+1));
        if (dotsArray.count == 0) {
            NSValue *element = [NSValue valueWithCGPoint:point];
            [dotsArray addObject:element];
        } else if ([self isPoint:point inArray:dotsArray]){
            //Если точка уже существует - генерируем новую
            --i;
        } else {
            NSValue *element = [NSValue valueWithCGPoint:point];
            [dotsArray addObject:element];
        }
    }
    
    NSLog(@"dots count = %lu", dotsArray.count);
    NSLog(@"field: %@", NSStringFromCGRect(kube));
    
    //Выводим все точки, если точка попала в поле указываем при выводе
    for (NSValue *element in dotsArray) {
        CGPoint point = [element CGPointValue];
        if (CGRectContainsPoint(kube, point)) {
            NSLog(@"point %@ exist in field", NSStringFromCGPoint(point));
        } else {
            NSLog(@"point %@", NSStringFromCGPoint(point));
        }
    }
    
    return YES;
}

//Вспомогательная функция для проверки есть ли уже такая точка в массиве
- (BOOL)isPoint:(CGPoint)point inArray:(NSMutableArray *)array {
    for (NSValue *element in array) {
        CGPoint dot = [element CGPointValue];
        if (dot.x == point.x && dot.y == point.y) {
            return YES;
        }
    }
    return NO;
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
