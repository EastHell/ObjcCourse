//
//  FriendListTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 19/04/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FriendListTableViewController.h"
#import "Friend.h"
#import "FriendListDataSource.h"
#import "FriendList.h"
#import "ImageCache.h"
#import "FriendTableViewCell.h"
#import "DetailedFriendTableViewController.h"

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
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.navigationItem.title = @"Friend list";
    
    [self.tableView
     registerClass:[FriendTableViewCell class]
     forCellReuseIdentifier:NSStringFromClass([FriendTableViewCell class])];
    
    [self loadMoreUsersFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:NSStringFromClass([FriendTableViewCell class])
                               forIndexPath:indexPath];
    
    if (indexPath.row == self.friendList.count - 20) {
        [self loadMoreUsersFromRow:self.friendList.count];
    }
    
    Friend *user = [self.friendList friendAtIndex:indexPath.row];
    [cell configureWithUserName:[NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName]];
    
    [[ImageCache publicCache] loadWithUrl:user.photoURL completion:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell addImage:image];
            [cell setNeedsLayout];
        });
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Friend *friend = [self.friendList friendAtIndex:indexPath.row];
    
    DetailedFriendTableViewController *vc = [[DetailedFriendTableViewController alloc] initWithUserId:friend.userID];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Utility

- (void)loadMoreUsersFromRow:(NSInteger)row {
    
    [self.friendList fetchFriendsWithCompletion:^(NSUInteger count) {
        
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
