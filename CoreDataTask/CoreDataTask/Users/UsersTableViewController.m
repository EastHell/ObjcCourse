//
//  UsersTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 25/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UsersTableViewController.h"
#import "CoreDataStack.h"
#import <CoreData/CoreData.h>
#import "CoreDataTask+CoreDataModel.h"
#import "AddUserTableViewController.h"
#import "UserTableViewCell.h"
#import "UserListContainer.h"

@interface UsersTableViewController ()

@property (strong, nonatomic) UserListContainer *userListContainer;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSMutableSet<NSManagedObjectID *> *usersIDs;

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    
    self.persistentContainer = [CoreDataStack defaultStack].persistentContainer;
    self.userListContainer = [[UserListContainer alloc] initWithTableView:self.tableView
                                                                  context:self.persistentContainer.viewContext];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"User"];
    [self.navigationItem setTitle:@"User list"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userListContainer.numberOfUsers;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"User" forIndexPath:indexPath];
    
    User *user = [self.userListContainer userAtIndexPath:indexPath];
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName]];
    [cell.emailLabel setText:user.email];
    cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        User *user = [self.userListContainer userAtIndexPath:indexPath];
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull backContext) {
            [backContext deleteObject:[backContext objectWithID:user.objectID]];
            [backContext save:nil];
        }];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    User *user = [self.userListContainer userAtIndexPath:indexPath];
    AddUserTableViewController *vc = [[AddUserTableViewController alloc] init];
    vc.objectID = [user objectID];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
