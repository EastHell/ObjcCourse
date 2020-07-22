//
//  FollowersTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 15/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "FollowersTableViewController.h"
#import "FollowersDataSource.h"
#import "FollowersList.h"
#import "FriendTableViewCell.h"
#import "User.h"
#import "ImageCache.h"

@interface FollowersTableViewController ()

@property (strong, nonatomic) id<FollowersDataSource> followers;
@property (strong, nonatomic) NSOperationQueue *sharedOperationQueue;
@property (strong, nonatomic) NSString *userID;

@end

@implementation FollowersTableViewController

- (instancetype)initWithUserID:(NSString *)userID
{
    self = [super init];
    if (self) {
        _userID = userID;
        _followers = [[FollowersList alloc] initWithUserID:userID];
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
    
    self.navigationItem.title = @"Followers";
    
    [self.tableView
     registerClass:[FriendTableViewCell class]
     forCellReuseIdentifier:NSStringFromClass([FriendTableViewCell class])];    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMoreUsersFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.followers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:NSStringFromClass([FriendTableViewCell class])
                                 forIndexPath:indexPath];
    
    if (indexPath.row == self.followers.count - 20) {
        [self loadMoreUsersFromRow:self.followers.count];
    }
    
    User *user = [self.followers followerAtIndex:indexPath.row];
    [cell configureWithUserName:[NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName]];
    
    [[ImageCache publicCache] loadWithUrl:user.photo50URL completion:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell addImage:image];
            [cell setNeedsLayout];
        });
    }];
    
    return cell;
}

#pragma mark - Utility

- (void)loadMoreUsersFromRow:(NSInteger)row {
    
    [self.followers fetchFollowersWithCompletion:^(NSUInteger fetchedFollowersCount) {
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < fetchedFollowersCount; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        __weak FollowersTableViewController *weakSelf = self;
        
        [self.sharedOperationQueue addOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView performBatchUpdates:^{
                    [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                } completion:nil];
            });
        }];
    }];
}

@end
