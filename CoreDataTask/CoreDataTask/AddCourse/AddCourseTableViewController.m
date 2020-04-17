//
//  AddCourseTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 17/03/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "AddCourseTableViewController.h"
#import "TextFieldTableViewCell.h"
#import "LabelTableViewCell.h"
#import "CoreDataStack.h"
#import "AddUserTableViewController.h"
#import "UserTableViewCell.h"
#import "SelectUsersTableViewController.h"

@interface AddCourseTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@property (strong, nonatomic) Course* course;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) TextFieldTableViewCell *nameTextFieldCell;
@property (strong, nonatomic) TextFieldTableViewCell *subjectTextFieldCell;
@property (strong, nonatomic) TextFieldTableViewCell *industryTextFieldCell;
@property (strong, nonatomic) LabelTableViewCell *teacherLabelCell;
@property (strong, nonatomic) LabelTableViewCell *saveButtonCell;
@property (strong, nonatomic) LabelTableViewCell *addStudentButtonCell;
@property (strong, nonatomic) NSArray<UITableViewCell *> *cells;

@end

@implementation AddCourseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;

    self.backgroundContext = [CoreDataStack.defaultStack.persistentContainer newBackgroundContext];
    
    if (self.objectID) {
        self.course = [self.backgroundContext objectWithID:self.objectID];
    } else {
        self.course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                    inManagedObjectContext:self.backgroundContext];
    }
    
    [self configureCells];
    [self initializeFetchedResultsController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Course";
        default:
            return @"Students";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][0];
    switch (section) {
        case 0:
            return self.cells.count;
        default:
            return 1 + [sectionInfo numberOfObjects];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            return self.cells[indexPath.row];
        default:
            if (indexPath.row == 0) {
                return self.addStudentButtonCell;
            } else {
                UserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"
                                                                              forIndexPath:indexPath];
                
                NSIndexPath *offsetIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
                User *student = [self.fetchedResultsController objectAtIndexPath:offsetIndexPath];
                
                [userCell.nameLabel setText:[NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName]];
                [userCell.emailLabel setText:student.email];
                
                return userCell;
            }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSIndexPath *offsetIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0];
        User *student = [self.fetchedResultsController objectAtIndexPath:offsetIndexPath];
        
        NSMutableSet<Course *> *mutableStudyCourses = [student.studyCourses mutableCopy];
        [mutableStudyCourses removeObject:self.course];
        [self.backgroundContext performBlock:^{
            student.studyCourses = [mutableStudyCourses copy];
        }];
    }
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:3 inSection:0]] ||
        [indexPath isEqual:[NSIndexPath indexPathForRow:4 inSection:0]] ||
        [indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:1]]) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *addStudentsIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *saveCourseIndexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    if ([indexPath isEqual:addStudentsIndexPath]) {
        [self addStudents];
    } else if ([indexPath isEqual:saveCourseIndexPath]) {
        [self saveCourse];
    }
}

#pragma mark - FetchedResultsController

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort, firstNameSort]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"ANY studyCourses == %@", self.course]];
    [request setReturnsObjectsAsFaults:NO];
    
    NSManagedObjectContext *moc = self.backgroundContext;
    
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
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSIndexPath *offsetNewIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + 1 inSection:newIndexPath.section+1];
        NSIndexPath *offsetIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section + 1];
        
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertRowsAtIndexPaths:@[offsetNewIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            case NSFetchedResultsChangeDelete:
                [self.tableView deleteRowsAtIndexPaths:@[offsetIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            case NSFetchedResultsChangeMove:
                [self.tableView reloadData];
                break;
            case NSFetchedResultsChangeUpdate:
                [self.tableView reloadRowsAtIndexPaths:@[offsetIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark - Utility

- (void)addStudents {
    SelectUsersTableViewController *vc = [[SelectUsersTableViewController alloc] init];
    vc.course = self.course;
    vc.context = self.backgroundContext;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [navVC setModalPresentationStyle:UIModalPresentationPopover];
    [navVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)saveCourse {
    [self.backgroundContext performBlockAndWait:^{
        self.course.name = self.nameTextFieldCell.field.text;
        self.course.subject = self.subjectTextFieldCell.field.text;
        self.course.industry = self.industryTextFieldCell.field.text;
        [self.backgroundContext save:nil];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureCells {
    
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"UserCell"];
    
    self.nameTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:@"TextFieldCell"];
    [self.nameTextFieldCell.field setPlaceholder:@"Enter name"];
    
    self.subjectTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"TextFieldCell"];
    [self.subjectTextFieldCell.field setPlaceholder:@"Enter subject"];
    
    self.industryTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:@"TextFieldCell"];
    [self.industryTextFieldCell.field setPlaceholder:@"Enter industry"];
    self.teacherLabelCell = [[LabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"LabelCell"];
    
    self.saveButtonCell = [[LabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"LabelCell"];
    [self.saveButtonCell.label setText:@"Save"];
    
    self.cells = @[self.nameTextFieldCell, self.subjectTextFieldCell, self.industryTextFieldCell,
                              self.teacherLabelCell, self.saveButtonCell];
    
    self.addStudentButtonCell = [[LabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:@"LabelCell"];
    [self.addStudentButtonCell.label setText:@"Add student"];
    
    if (self.course) {
        [self.nameTextFieldCell.field setText:self.course.name];
        [self.subjectTextFieldCell.field setText:self.course.subject];
        [self.industryTextFieldCell.field setText:self.course.industry];
        if (self.course.teacher) {
            User *teacher = self.course.teacher;
            [self.teacherLabelCell.label
             setText:[NSString stringWithFormat:@"%@, %@", teacher.firstName, teacher.lastName]];
        } else {
            [self.teacherLabelCell.label setText:@"Select teacher"];
        }
    }
}

@end
