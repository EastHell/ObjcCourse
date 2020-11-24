//
//  AddUserTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 24/02/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "AddUserTableViewController.h"
#import "TextFieldTableViewCell.h"
#import "LabelTableViewCell.h"
#import "CoreDataStack.h"

@interface AddUserTableViewController ()

@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) TextFieldTableViewCell *firstNameTextFieldCell;
@property (strong, nonatomic) TextFieldTableViewCell *lastNameTextFieldCell;
@property (strong, nonatomic) TextFieldTableViewCell *emailTextFieldCell;
@property (strong, nonatomic) LabelTableViewCell *saveButtonCell;
@property (strong, nonatomic) NSArray<UITableViewCell *> *cells;
@property (strong, nonatomic) NSArray<Course *> *teachCourses;
@property (strong, nonatomic) NSArray<Course *> *studyCourses;
@property (strong, nonatomic) NSArray<NSSortDescriptor *> *coursesSortDescriptors;

@end

@implementation AddUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    
    self.backgroundContext = [CoreDataStack.defaultStack.persistentContainer newBackgroundContext];
    
    self.navigationItem.title = @"Add user";
    
    if (self.objectID) {
        self.user = [self.backgroundContext objectWithID:self.objectID];
        self.navigationItem.title = @"Edit user";
    }
    
    [self configureCells];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"User info";
        case 1:
            if (self.user.teachCourses.count > 0) {
                return @"Teach";
            }
            break;
        case 2:
            if (self.user.studyCourses.count > 0) {
                return @"Study";
            }
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.cells.count;
        case 1:
            return self.user.teachCourses.count;
        case 2:
            return self.user.studyCourses.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = self.cells[indexPath.row];
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:@"CourseCell"];
            }
            Course *course = self.teachCourses[indexPath.row];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", course.subject, course.name]];
            [cell.detailTextLabel setText:course.industry];
            break;
        }
            case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:@"CourseCell"];
            }
            Course *course = self.studyCourses[indexPath.row];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", course.subject, course.name]];
            if (course.teacher) {
                [cell.detailTextLabel
                 setText:[NSString stringWithFormat:@"%@, %@", course.teacher.firstName, course.teacher.lastName]];
            } else {
                [cell.detailTextLabel setText:@""];
            }
            break;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self save];
    }
}

#pragma mark - Utility

- (void)save {
    
    NSString *firstName = self.firstNameTextFieldCell.field.text;
    NSString *lastName = self.lastNameTextFieldCell.field.text;
    NSString *email = self.emailTextFieldCell.field.text;
    
    bool failed = false;
    
    NSString *nameRegex = @"^[^\\cA-\\c_\\s][^\\cA-\\c_]+$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![nameTest evaluateWithObject:firstName]) {
        
        failed = true;
        [UIView animateWithDuration:0.8
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [UIView setAnimationRepeatCount:1];
                             [self.firstNameTextFieldCell setBackgroundColor:[UIColor redColor]];
                         }
                         completion:^(BOOL finished) {
                             [self.firstNameTextFieldCell setBackgroundColor:[UIColor clearColor]];
                         }];
    }
    if (![nameTest evaluateWithObject:lastName]) {
        
        failed = true;
        [UIView animateWithDuration:0.8
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [UIView setAnimationRepeatCount:1];
                             [self.lastNameTextFieldCell setBackgroundColor:[UIColor redColor]];
                         }
                         completion:^(BOOL finished) {
                             [self.lastNameTextFieldCell setBackgroundColor:[UIColor clearColor]];
                         }];
    }
    if (![emailTest evaluateWithObject:email]) {
        
        failed = true;
        [UIView animateWithDuration:0.8
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [UIView setAnimationRepeatCount:1];
                             [self.emailTextFieldCell setBackgroundColor:[UIColor redColor]];
                         }
                         completion:^(BOOL finished) {
                             [self.emailTextFieldCell setBackgroundColor:[UIColor clearColor]];
                         }];
    }
    
    if (failed) {
        [self.saveButtonCell setSelected:NO animated:YES];
        return;
    }
    
    [self.backgroundContext performBlock:^{
        if (!self.user) {
            self.user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                 inManagedObjectContext:self.backgroundContext];
        }
        [self.user setFirstName:firstName];
        [self.user setLastName:lastName];
        [self.user setEmail:email];
        [self.backgroundContext save:nil];
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureCells {
    
    self.firstNameTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:@"TextFieldCell"];
    [self.firstNameTextFieldCell.field setPlaceholder:@"Enter first name"];
    
    self.lastNameTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                         reuseIdentifier:@"TextFieldCell"];
    [self.lastNameTextFieldCell.field setPlaceholder:@"Enter last name"];
    
    self.emailTextFieldCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:@"TextFieldCell"];
    [self.emailTextFieldCell.field setPlaceholder:@"Enter email"];
    
    if (self.user) {
        [self.firstNameTextFieldCell.field setText:self.user.firstName];
        [self.lastNameTextFieldCell.field setText:self.user.lastName];
        [self.emailTextFieldCell.field setText:self.user.email];
    }
    
    self.saveButtonCell = [[LabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:@"ButtonCell"];
    [self.saveButtonCell.label setText:@"Save"];
}

- (NSArray<UITableViewCell *> *)cells {
    if (!_cells) {
        _cells = @[self.firstNameTextFieldCell, self.lastNameTextFieldCell, self.emailTextFieldCell, self.saveButtonCell];
    }
    
    return _cells;
}

- (NSArray<Course *> *)teachCourses {
    
    if (!_teachCourses && self.user.teachCourses) {
        _teachCourses = [self.user.teachCourses sortedArrayUsingDescriptors:self.coursesSortDescriptors];
    }
    
    return _teachCourses;
}

- (NSArray<Course *> *)studyCourses {
    
    if (!_studyCourses && self.user.studyCourses) {
        _studyCourses = [self.user.studyCourses sortedArrayUsingDescriptors:self.coursesSortDescriptors];
    }
    
    return _studyCourses;
}

- (NSArray<NSSortDescriptor *> *)coursesSortDescriptors {
    
    if (!_coursesSortDescriptors) {
        NSSortDescriptor *industrySort = [NSSortDescriptor sortDescriptorWithKey:@"industry" ascending:YES];
        NSSortDescriptor *subjectSort = [NSSortDescriptor sortDescriptorWithKey:@"subject" ascending:YES];
        NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        _coursesSortDescriptors = @[industrySort, subjectSort, nameSort];
    }
    
    return _coursesSortDescriptors;
}



@end
