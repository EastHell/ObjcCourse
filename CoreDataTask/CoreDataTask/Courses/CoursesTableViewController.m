//
//  CoursesTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 17/03/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "CoreDataStack.h"
#import <CoreData/CoreData.h>
#import "CoreDataTask+CoreDataModel.h"
#import "AddCourseTableViewController.h"

@interface CoursesTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

@implementation CoursesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.persistentContainer = [CoreDataStack defaultStack].persistentContainer;
    self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self initializeFetchedResultsController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return sectionInfo.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"labelCell"];
    }
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", course.subject, course.name]];
    
    if (course.teacher) {
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@", course.teacher.firstName, course.teacher.lastName]];
    } else {
        [cell.detailTextLabel setText:@""];
    }
    
    cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    AddCourseTableViewController *vc = [[AddCourseTableViewController alloc] init];
    vc.objectID = [course objectID];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull backContext) {
            [backContext deleteObject:[backContext objectWithID:course.objectID]];
            [backContext save:nil];
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - FetchedResultsController

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    
    NSSortDescriptor *industrySort = [NSSortDescriptor sortDescriptorWithKey:@"industry" ascending:YES];
    NSSortDescriptor *subjectSort = [NSSortDescriptor sortDescriptorWithKey:@"subject" ascending:YES];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[industrySort, subjectSort, nameSort]];
    
    NSManagedObjectContext *moc = [CoreDataStack defaultStack].persistentContainer.viewContext; //Retrieve the main queue NSManagedObjectContext
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                          managedObjectContext:moc
                                                                            sectionNameKeyPath:@"industry"
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

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
