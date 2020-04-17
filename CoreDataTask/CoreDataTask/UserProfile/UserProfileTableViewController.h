//
//  UserProfileTableViewController.h
//  CoreDataTask
//
//  Created by Aleksandr on 16/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfileTableViewController : UITableViewController

- (instancetype)initWithUser:(User *)user;

@end

NS_ASSUME_NONNULL_END
