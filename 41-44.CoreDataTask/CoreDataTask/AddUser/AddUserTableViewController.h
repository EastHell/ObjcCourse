//
//  AddUserTableViewController.h
//  CoreDataTask
//
//  Created by Aleksandr on 24/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTask+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddUserTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectID *objectID;

@end

NS_ASSUME_NONNULL_END
