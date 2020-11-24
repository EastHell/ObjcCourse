//
//  TeachersTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 18/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "TeachersTableViewController.h"
#import "CoreDataStack.h"
#import <CoreData/CoreData.h>
#import "CoreDataTask+CoreDataModel.h"
#import "UserProfileTableViewController.h"

@interface TeachersTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *frc;

@end

@implementation TeachersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    self.tableView.allowsSelection = YES;
    
    [self.navigationItem setTitle:@"Teachers"];
    [self initFetchedResultsController];
}

- (void)initFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    
    NSSortDescriptor *industrySort = [NSSortDescriptor sortDescriptorWithKey:@"industry" ascending:YES];
    NSSortDescriptor *subjectSort = [NSSortDescriptor sortDescriptorWithKey:@"subject" ascending:YES];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[industrySort, subjectSort, nameSort]];
    
    NSManagedObjectContext *moc = CoreDataStack.defaultStack.persistentContainer.viewContext;
    
    [self setFrc:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc
                                                       sectionNameKeyPath:@"subject"
                                                                cacheName:nil]];
    
    [self.frc setDelegate:self];
    
    NSError *error = nil;
    
    if (![self.frc performFetch:&error]) {
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.frc.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    NSArray *teachers = [sectionInfo.objects valueForKeyPath:@"@distinctUnionOfObjects.teacher"];
    if (teachers.count > 0) {
        return sectionInfo.name;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    NSArray *teachers = [sectionInfo.objects valueForKeyPath:@"@distinctUnionOfObjects.teacher"];
    return teachers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TeacherCell"];
    }
    
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[indexPath.section];
    NSArray<User *> *teachers = [sectionInfo.objects valueForKeyPath:@"@distinctUnionOfObjects.teacher"];
    NSString *firstName = teachers[indexPath.row].firstName;
    NSString *lastName = teachers[indexPath.row].lastName;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.detailTextLabel.text = [NSString
                                 stringWithFormat:@"Teach %lu courses", teachers[indexPath.row].teachCourses.count];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[indexPath.section];
    NSArray<User *> *teachers = [sectionInfo.objects valueForKeyPath:@"@distinctUnionOfObjects.teacher"];
    [self showProfileForTeacher:teachers[indexPath.row]];
}

- (void)showProfileForTeacher:(User *)teacher {
    UserProfileTableViewController *vc = [[UserProfileTableViewController alloc] initWithUser:teacher];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
