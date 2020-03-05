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

@property (strong, nonatomic) NSArray<UITableViewCell *> *cells;
@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

@implementation AddUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    
    self.persistentContainer = [CoreDataStack defaultStack].persistentContainer;
    
    [self configureCells];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = self.cells[indexPath.row].reuseIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell = self.cells[indexPath.row];
    
    return cell;
}

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
    TextFieldTableViewCell *firstNameCell = (TextFieldTableViewCell *)self.cells[0];
    NSString *firstName = firstNameCell.field.text;
    TextFieldTableViewCell *lastNameCell = (TextFieldTableViewCell *)self.cells[1];
    NSString *lastName = lastNameCell.field.text;
    TextFieldTableViewCell *emailCell = (TextFieldTableViewCell *)self.cells[2];
    NSString *email = emailCell.field.text;
    [self.persistentContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull backContext) {
        User *user;
        if (self.objectID) {
            user = [backContext objectWithID:self.objectID];
        } else {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                 inManagedObjectContext:backContext];
        }
        [user setFirstName:firstName];
        [user setLastName:lastName];
        [user setEmail:email];
        [backContext save:nil];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureCells {
    
    [self.tableView registerClass:[TextFieldTableViewCell class] forCellReuseIdentifier:@"TextFieldCell"];
    [self.tableView registerClass:[LabelTableViewCell class] forCellReuseIdentifier:@"ButtonCell"];
    
    TextFieldTableViewCell *firstNameCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:@"TextFieldCell"];
    [firstNameCell.label setText:@"First name"];
    [firstNameCell.field setPlaceholder:@"Enter first name"];
    [firstNameCell.field setText:self.firstName];
    
    TextFieldTableViewCell *lastNameCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                         reuseIdentifier:@"TextFieldCell"];
    [lastNameCell.label setText:@"Last name"];
    [lastNameCell.field setPlaceholder:@"Enter last name"];
    [lastNameCell.field setText:self.lastName];
    
    TextFieldTableViewCell *emailCell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                      reuseIdentifier:@"TextFieldCell"];
    [emailCell.label setText:@"Email"];
    [emailCell.field setPlaceholder:@"Enter email"];
    [emailCell.field setText:self.email];
    
    LabelTableViewCell *saveButtonCell = [[LabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                   reuseIdentifier:@"ButtonCell"];
    [saveButtonCell.label setText:@"Save"];
    
    self.cells = @[firstNameCell, lastNameCell, emailCell, saveButtonCell];
}

@end
