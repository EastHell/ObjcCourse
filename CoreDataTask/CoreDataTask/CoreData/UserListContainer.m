//
//  UserListContainer.m
//  CoreDataTask
//
//  Created by Aleksandr on 11/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UserListContainer.h"
#import "CoreDataStack.h"
#import <UIKit/UIKit.h>

@interface UserListContainer () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation UserListContainer

- (instancetype)initWithTableView:(UITableView *)tableView context:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.context = context;
        [self initializeFetchedResultsController];
    }
    return self;
}

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort, firstNameSort]];
    
    NSManagedObjectContext *moc = self.context;
    
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

- (NSUInteger)numberOfUsers {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[0];
    return [sectionInfo numberOfObjects];
}

- (User *)userAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma mark - FetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
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
    });
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
    });
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView endUpdates];
    });
}



@end
