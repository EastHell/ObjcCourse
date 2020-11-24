//
//  UserListContainer.h
//  CoreDataTask
//
//  Created by Aleksandr on 11/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User, UITableView, NSManagedObjectContext;
@protocol NSFetchedResultsControllerDelegate;

@interface UserListContainer : NSObject

@property (assign, nonatomic) NSUInteger numberOfUsers;

- (instancetype)initWithTableView:(UITableView *)tableView context:(NSManagedObjectContext *)context;
- (User *)userAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
