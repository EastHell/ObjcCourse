//
//  SelectUsersTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 11/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "SelectUsersTableViewController.h"
#import "UserListContainer.h"
#import "UserTableViewCell.h"
#import "CoreDataTask+CoreDataModel.h"
#import "CoreDataStack.h"

@interface SelectUsersTableViewController ()

@property (strong, nonatomic) UserListContainer *userListContainer;
@property (strong, nonatomic) NSMutableSet<User *> *users;
@property (assign, nonatomic) SelectUsersTableViewControllerType type;
@property (copy, nonatomic, nullable) void (^completionBlock)(void);

@end

@implementation SelectUsersTableViewController

- (instancetype)initWithType:(SelectUsersTableViewControllerType)type
             completionBlock:(void (^__nullable)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.type = type;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    self.userListContainer = [[UserListContainer alloc] initWithTableView:self.tableView
                                                                  context:self.context];
    
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"User"];
    [self.tableView setAllowsMultipleSelection:YES];
    
    if (self.type == SelectUsersTableViewControllerTypeAddStudents) {
        self.users = [self.course.students mutableCopy];
    } else {
        self.users = self.course.teacher?[NSMutableSet setWithObject:self.course.teacher]:[NSMutableSet new];
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(dismiss:)];
}

#pragma mark - Actions

- (void)save:(id)sender {
    [self.context performBlock:^{
        if (self.type == SelectUsersTableViewControllerTypeAddStudents) {
            self.course.students = self.users;
        } else {
            self.course.teacher = [self.users anyObject];
        }
    }];
    [self dismissViewControllerAnimated:YES completion:self.completionBlock];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if ([self.users containsObject:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.users addObject:[self.userListContainer userAtIndexPath:indexPath]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.users removeObject:[self.userListContainer userAtIndexPath:indexPath]];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
