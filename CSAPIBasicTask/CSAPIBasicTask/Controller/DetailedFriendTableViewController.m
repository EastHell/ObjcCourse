//
//  DetailedFriendTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "DetailedFriendTableViewController.h"
#import "UserInfo.h"
#import "User.h"
#import "ImageTableViewCell.h"
#import "ImageCache.h"
#import "FollowersTableViewController.h"
#import "SubscriptionsTableViewController.h"

@interface DetailedFriendTableViewController ()

@property (strong, nonatomic) NSMutableArray *cells;
@property (strong, nonatomic) UserInfo *userInfo;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *userId;

@end

@implementation DetailedFriendTableViewController

- (instancetype)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        self.userInfo = [UserInfo new];
        self.cells = [NSMutableArray new];
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak DetailedFriendTableViewController *weakSelf = self;
    
    [self.userInfo fetchUserInfoForUserId:self.userId withCompletion:^(User * _Nonnull fetchedUser) {
        
        [weakSelf configureCellsWithUser:fetchedUser];
        
        [weakSelf.tableView reloadData];
        
        weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@ %@", fetchedUser.firstName, fetchedUser.lastName];
    }];
    
    self.navigationItem.title = @"Friend bio";
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 80.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cells[indexPath.row];
}

#pragma marl - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == self.cells.count - 2) {
        
        FollowersTableViewController *vc = [[FollowersTableViewController alloc] initWithUserID:self.userId];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == self.cells.count - 1) {
        
        SubscriptionsTableViewController *vc = [[SubscriptionsTableViewController alloc] initWithUserID:self.userId];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Cells

- (void)configureCellsWithUser:(User *)user {
    
    self.user = user;
    
    if (user.photoMaxOrigURL) {
        
        ImageTableViewCell *cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        __weak UITableView *weakTableView = self.tableView;
        
        [[ImageCache publicCache] loadWithUrl:user.photoMaxOrigURL completion:^(UIImage * _Nonnull image) {
            [weakTableView performBatchUpdates:^{
                if (cell) {
                    [cell addImage:image];
                    [cell setNeedsLayout];
                }
            } completion:nil];
        }];
        
        [self.cells addObject:cell];
    }
    
    if (user.birthDate) {
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"dd.MM.YYYY"];
        
        NSString *bdate = [dateFormatter stringFromDate:user.birthDate];
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"Birth date:";
        cell.detailTextLabel.text = bdate;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.cells addObject:cell];
    }
    
    if (user.sex) {
        
        NSString *sex = user.sex == UserSexMale ? @"Male" : @"Female";
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"Sex:";
        cell.detailTextLabel.text = sex;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.cells addObject:cell];
    }
    
    if (user.city) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"City:";
        cell.detailTextLabel.text = user.city;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.cells addObject:cell];
    }
    
    UITableViewCell *followersCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    followersCell.textLabel.text = @"Followers:";
    followersCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", user.counters.followers];
    [self.cells addObject:followersCell];
    
    UITableViewCell *subscriptionsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    subscriptionsCell.textLabel.text = @"Subscriptions:";
    subscriptionsCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", user.counters.subscriptions];
    [self.cells addObject:subscriptionsCell];
}

@end
