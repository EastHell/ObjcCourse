//
//  CoreDataStack.h
//  CoreDataTask
//
//  Created by Aleksandr on 18/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStack : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (CoreDataStack *)defaultStack;

@end

NS_ASSUME_NONNULL_END
