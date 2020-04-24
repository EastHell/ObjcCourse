//
//  FriendListTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendListTableViewController.h"
#import "User.h"
#import "FriendList.h"

@interface FriendListTableViewController ()

@property (strong, nonatomic) FriendList *friendList;

@end

@implementation FriendListTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.friendList = [FriendList new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.f;
    [self.tableView setAllowsSelection:NO];
    
    self.navigationItem.title = @"Friend list";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UserCell"];
    
    __weak FriendListTableViewController *weakSelf = self;
    [self.tableView performBatchUpdates:^{
        [weakSelf.friendList loadMoreWithCompletion:^(BOOL success, NSUInteger count) {
            NSMutableArray *newPaths = [NSMutableArray array];
            for (NSUInteger i = 0; i < count; i++) {
                [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            [weakSelf.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView reloadData];
        }];
    } completion:^(BOOL finished) {
        //NSLog(@"Loaded");
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    cell.imageView.image = nil;
    
    if (indexPath.row == self.friendList.count - 1) {
        [tableView performBatchUpdates:^{
            [self.friendList loadMoreWithCompletion:^(BOOL success, NSUInteger count) {
                NSMutableArray *newPaths = [NSMutableArray array];
                for (NSUInteger i = 0; i < count; i++) {
                    [newPaths addObject:[NSIndexPath indexPathForRow:indexPath.row+i inSection:0]];
                }
                [tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        } completion:^(BOOL finished) {
            //NSLog(@"Loaded");
        }];
    }
    
    User *user = [self.friendList userAtIndex:indexPath.row];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    cell.textLabel.text = [NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName];
    cell.imageView.image = user.photo;
    
    return cell;
}

@end
