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

@end

@implementation AddUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    
    self.backgroundContext = [CoreDataStack.defaultStack.persistentContainer newBackgroundContext];
    
    if (self.objectID) {
        self.user = [self.backgroundContext objectWithID:self.objectID];
    }
    
    [self configureCells];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = self.cells[indexPath.row];
    
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

@end
