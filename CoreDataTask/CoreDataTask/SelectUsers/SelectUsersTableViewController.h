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

@interface SelectUsersTableViewController : UITableViewController

@property (strong, nonatomic) Course *course;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

NS_ASSUME_NONNULL_END
