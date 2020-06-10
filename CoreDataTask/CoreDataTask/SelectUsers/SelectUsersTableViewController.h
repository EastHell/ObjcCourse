//
//  SelectUsersTableViewController.h
//  CoreDataTask
//
//  Created by Aleksandr on 11/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Course;

typedef NS_ENUM(NSInteger, SelectUsersTableViewControllerType) {
    SelectUsersTableViewControllerTypeAddStudents,          // Adding multiple students
    SelectUsersTableViewControllerTypeAddTeacher            // Sdding single teacher
};

@interface SelectUsersTableViewController : UITableViewController

@property (strong, nonatomic) Course *course;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (instancetype)initWithType:(SelectUsersTableViewControllerType)type
             completionBlock:(void (^__nullable)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
