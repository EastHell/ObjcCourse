//
//  FriendListTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendListTableViewController.h"
#import "User.h"
#import "FriendListDataSource.h"
#import "FriendList.h"
#import "ImageCache.h"
#import "UserTableViewCell.h"

@interface FriendListTableViewController ()

@property (strong, nonatomic) id<FriendListDataSource> friendList;
@property (strong, nonatomic) NSOperationQueue *sharedOperationQueue;

@end

@implementation FriendListTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _friendList = [FriendList new];
        _sharedOperationQueue = [NSOperationQueue new];
        _sharedOperationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70.f;
    self.tableView.allowsSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.navigationItem.title = @"Friend list";
    
    [self.tableView
     registerClass:[UserTableViewCell class]
     forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    [self loadMoreUsersFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:NSStringFromClass([UserTableViewCell class])
                               forIndexPath:indexPath];
    
    if (indexPath.row == self.friendList.count - 10) {
        [self loadMoreUsersFromRow:self.friendList.count];
    }
    
    User *user = [self.friendList userAtIndex:indexPath.row];
    [cell configureWithUserName:[NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName]];
    
    [[ImageCache publicCache] loadWithUrl:user.photoURL completion:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell addImage:image];
            [cell setNeedsLayout];
        });
    }];
    
    return cell;
}

#pragma mark - Utility

- (void)loadMoreUsersFromRow:(NSInteger)row {
    
    [self.friendList fetchUsersWithCompletion:^(NSUInteger count) {
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        __weak FriendListTableViewController *weakSelf = self;
        
        [self.sharedOperationQueue addOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView performBatchUpdates:^{
                    [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                } completion:^(BOOL finished) {
                }];
            });
        }];
    }];
}

@end
