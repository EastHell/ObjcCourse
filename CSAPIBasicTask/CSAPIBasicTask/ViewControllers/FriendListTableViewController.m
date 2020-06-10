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
#import "ImageCacher.h"
#import "NetworkManager.h"
#import "UserTableViewCell.h"

@interface FriendListTableViewController ()

@property (strong, nonatomic) FriendList *friendList;
@property (assign, nonatomic) BOOL isLoading;

@end

@implementation FriendListTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
      _friendList = [FriendList new];
      _isLoading = NO;
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.rowHeight = 70.f;
  self.tableView.allowsSelection = NO;
  self.tableView.showsVerticalScrollIndicator = NO;
  
  self.navigationItem.title = @"Friend list";
  
  [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"UserCell"];
  
  [self loadMoreUsersFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
  
  if ((indexPath.row >= self.friendList.count - 10) && !self.isLoading) {
      [self loadMoreUsersFromRow:self.friendList.count];
  }
  
  User *user = [self.friendList userAtIndex:indexPath.row];
  cell.usernameLabel.text = [NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName];
  
  [cell addImage:[[ImageCacher sharedImageCacher] getImageForUrl:user.photoURL]];
  
  if (!cell.imageView.image) {
    NSUInteger requestIdentifier = [[NetworkManager sharedNetwork] performRequestWithUrl:user.photoURL onSuccess:^(NSData * _Nonnull data) {
      
      UIImage *image = [UIImage imageWithData:data];
      
      if (image) {
        [[ImageCacher sharedImageCacher] cacheImage:image forUrl:user.photoURL];
        dispatch_async(dispatch_get_main_queue(), ^{
          //[cell addImage:image];
          [cell addImage:nil];
          [cell setNeedsLayout];
        });
      }
      
    } onFailure:^(NSError * _Nonnull error) {
      
      NSLog(@"Image error: %@", error);
    }];
    
    if (!cell.onReuse) {
      cell.onReuse = ^{
        [[NetworkManager sharedNetwork] cancelRequestWithIdentifier:requestIdentifier];
      };
    }
  }
  
  return cell;
}

#pragma mark - Utility

- (void)loadMoreUsersFromRow:(NSInteger)row {
  
  self.isLoading = YES;
  
  [self.friendList loadMoreWithCompletion:^(NSUInteger count) {
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
    }
    
    __weak FriendListTableViewController *weakSelf = self;
    
    [weakSelf.tableView performBatchUpdates:^{
      [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    } completion:^(BOOL finished) {
      weakSelf.isLoading = NO;
    }];
  }];
}

@end
