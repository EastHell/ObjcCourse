//
//  UserProfileTableViewController.m
//  CoreDataTask
//
//  Created by Aleksandr on 16/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "UserProfileTableViewController.h"
#import "CoreDataTask+CoreDataModel.h"

@interface UserProfileTableViewController ()

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray<NSString *> *userInfo;
@property (strong, nonatomic) NSArray<Course *> *teachCourses;
@property (strong, nonatomic) NSArray<Course *> *studyCourses;

@end

@implementation UserProfileTableViewController

#pragma mark - Initializers

- (instancetype)initWithUser:(User *)user
{
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    
    self.tableView.allowsSelection = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back:)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"textCell"];
    
    [self.navigationItem setTitle:@"User Info"];
}

#pragma mark - Actions

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"User";
        case 1:
            if (self.user.teachCourses.count > 0) {
                return @"Teach courses";
            }
            break;
        case 2:
            if (self.user.studyCourses.count > 0) {
                return @"Study courses";
            }
            break;
        default:
            return nil;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return self.user.teachCourses.count;
        case 2:
            return self.user.studyCourses.count;
        default:
            return 0;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
            [cell.textLabel setText:self.userInfo[indexPath.row]];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:@"courseCell"];
                Course *course = self.teachCourses[indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", course.subject, course.name];
                cell.detailTextLabel.text = course.industry;
            }
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:@"courseCell"];
                Course *course = self.studyCourses[indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", course.subject, course.name];
                cell.detailTextLabel.text = course.industry;
            }
            break;
        }
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Utility

- (NSArray<NSString *> *)userInfo {
    
    if (!_userInfo && self.user) {
        _userInfo = @[self.user.firstName, self.user.lastName, self.user.email];
    }
    
    return _userInfo;
}

- (NSArray<Course *> *)teachCourses {
    
    if (!_teachCourses && self.user) {
        _teachCourses = [self.user.teachCourses allObjects];
    }
    
    return _teachCourses;
}

- (NSArray<Course *> *)studyCourses {
    
    if (!_studyCourses && self.user) {
        _studyCourses = [self.user.studyCourses allObjects];
    }
    
    return _studyCourses;
}

@end
