//
//  AppDelegate.m
//  ArraysTasks
//
//  Created by Aleksandr on 21/03/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ASBiker.h"
#import "ASRunner.h"
#import "ASSwimmer.h"
#import "ASSuperHuman.h"
#import "ASBird.h"
#import "ASDog.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1st level
    NSLog(@"========1st level==============");
    ASBiker* biker = [[ASBiker alloc] init];
    ASRunner* runner = [[ASRunner alloc] init];
    ASSwimmer* swimmer = [[ASSwimmer alloc] init];
    ASHuman* human = [[ASHuman alloc] init];
    
    NSArray* array = [NSArray arrayWithObjects:biker, runner, swimmer, human, nil];
    
    for (ASHuman* obj in array) {
        NSLog(@"Name: %@\tHeight: %f\tWeight: %f\tSex: %@", obj.name, obj.height, obj.weight, obj.sex);
        
        [human move];
    }
    
    //2nd level
    NSLog(@"========2nd level==============");
    ASSuperHuman* superHuman = [[ASSuperHuman alloc] init];
    
    NSArray* secondArray = [NSArray arrayWithObjects:biker, runner, swimmer, human, superHuman, nil];
    
    for (NSInteger i = [secondArray count] - 1; i > 0; i--) {
        ASHuman* obj = (ASHuman*) [secondArray objectAtIndex:i];
        
        NSLog(@"Name: %@\tHeight: %f\tWeight: %f\tSex: %@", obj.name, obj.height, obj.weight, obj.sex);
        
        if ([obj isKindOfClass:[ASSuperHuman class]]) {
            ASSuperHuman* superObj = (ASSuperHuman*) obj;
            NSLog(@"PantsColor: %@\tSuperpower:%@", superObj.pantsColor, superObj.superPower);
        }
        [human move];
    }
    
    //3rd level
    NSLog(@"========3rd level==============");
    ASAnimal* animal = [[ASAnimal alloc] init];
    ASBird* bird = [[ASBird alloc] init];
    ASDog* dog = [[ASDog alloc] init];
    
    NSArray* thirdArray = [NSArray arrayWithObjects:biker, runner, swimmer, human, superHuman, animal, bird, dog, nil];
    
    for (NSObject* obj in thirdArray) {
        if ([obj isKindOfClass:[ASHuman class]]) {
            ASHuman* humanObj = (ASHuman*) obj;
            NSLog(@"IT's a human class");
            NSLog(@"Name: %@\tHeight: %f\tWeight: %f\tSex: %@", humanObj.name, humanObj.height, humanObj.weight, humanObj.sex);
            [humanObj move];
        }
        if ([obj isKindOfClass:[ASAnimal class]]) {
            ASAnimal* animalObj = (ASAnimal*) obj;
            NSLog(@"IT's an animal class");
            NSLog(@"Numbers of legs: %ld\tMoving speed: %ld", animalObj.nubersOfLegs, animalObj.movingSpeed);
            [animalObj move];
        }
    }
    
    //4th level
    NSLog(@"========3th level==============");
    NSArray* humanArray = [NSArray arrayWithObjects:biker, runner, swimmer, human, superHuman, nil];
    NSArray* animalArray = [NSArray arrayWithObjects:animal, bird, dog, nil];
    
    for (NSUInteger i = 0; i < (humanArray.count < animalArray.count ? animalArray.count : humanArray.count); i++) {
        if (i < humanArray.count) {
            ASHuman* obj = [humanArray objectAtIndex:i];
            NSLog(@"Human name %@", obj.name);
        }
        if (i < animalArray.count) {
            ASAnimal* obj = [animalArray objectAtIndex:i];
            NSLog(@"Animal speed %ld", obj.movingSpeed);
        }
    }
    
    //5th level
    NSLog(@"========5th level==============");
    NSMutableArray* mixArray = [NSMutableArray arrayWithArray:animalArray];
    [mixArray addObjectsFromArray:humanArray];
    
    NSArray* sortedArray = [mixArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[ASHuman class]] && [obj2 isKindOfClass:[ASHuman class]]){
            ASHuman* humanObj1 = (ASHuman*) obj1;
            ASHuman* humanObj2 = (ASHuman*) obj2;
            return [humanObj1.name compare:humanObj2.name];
        }
        if ([obj1 isKindOfClass:[ASAnimal class]] && [obj2 isKindOfClass:[ASAnimal class]]) {
            ASAnimal* animalObj1 = (ASAnimal*) obj1;
            ASAnimal* animalObj2 = (ASAnimal*) obj2;
            if (animalObj1.nubersOfLegs > animalObj2.nubersOfLegs) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }
        if (([obj1 isKindOfClass:[ASAnimal class]]) && ([obj2 isKindOfClass:[ASHuman class]])) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    for (NSObject* obj in sortedArray) {
        if ([obj isKindOfClass:[ASHuman class]]) {
            ASHuman* humanObj = (ASHuman*) obj;
            NSLog(@"IT's a human class");
            NSLog(@"Name: %@\tHeight: %f\tWeight: %f\tSex: %@", humanObj.name, humanObj.height, humanObj.weight, humanObj.sex);
            [humanObj move];
        }
        if ([obj isKindOfClass:[ASAnimal class]]) {
            ASAnimal* animalObj = (ASAnimal*) obj;
            NSLog(@"IT's an animal class");
            NSLog(@"Numbers of legs: %ld\tMoving speed: %ld", animalObj.nubersOfLegs, animalObj.movingSpeed);
            [animalObj move];
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
