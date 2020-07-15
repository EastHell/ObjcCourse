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
    
    self.tableView.estimatedRowHeight = 80.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cells[indexPath.row];
}

- (void)configureCellsWithUser:(User *)user {
    
    self.user = user;
    
    if (user.firstName || user.lastName) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.cells addObject:cell];
    }
    
    if (user.photoMaxOrigURL) {
        
        ImageTableViewCell *cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
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
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = [NSString stringWithFormat:@"Birth date: %@", bdate];
        [self.cells addObject:cell];
    }
    
    if (user.sex) {
        
        NSString *sex = user.sex == UserSexMale ? @"Male" : @"Female";
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = [NSString stringWithFormat:@"Sex: %@", sex];
        [self.cells addObject:cell];
    }
    
    if (user.city) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = [NSString stringWithFormat:@"City: %@", user.city];
        [self.cells addObject:cell];
    }
}

@end
