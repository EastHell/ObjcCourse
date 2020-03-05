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

@interface UsersTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.persistentContainer = [CoreDataStack defaultStack].persistentContainer;
    self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"labelCell"];
    
    [self initializeFetchedResultsController];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell" forIndexPath:indexPath];
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:user.firstName];
    cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

#pragma mark - FetchedResultsController

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort, firstNameSort]];
    
    NSManagedObjectContext *moc = [CoreDataStack defaultStack].persistentContainer.viewContext; //Retrieve the main queue NSManagedObjectContext
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                          managedObjectContext:moc
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

#pragma mark - FetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView reloadData];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    AddUserTableViewController *vc = [[AddUserTableViewController alloc] init];
    vc.firstName = user.firstName;
    vc.lastName = user.lastName;
    vc.email = user.email;
    vc.objectID = [user objectID];
    [self.navigationController pushViewController:vc animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull backContext) {
            [backContext deleteObject:[backContext objectWithID:user.objectID]];
            [backContext save:nil];
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
