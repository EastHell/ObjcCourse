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
    
    [self loadMoreUsersFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
  
  if (indexPath.row == self.friendList.count - 1) {
      [self loadMoreUsersFromRow:indexPath.row+1];
  }
  
  User *user = [self.friendList userAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName];
  
  cell.imageView.image = [[ImageCacher sharedImageCacher] getImageForUrl:user.photoURL];
  
  if (!cell.imageView.image) {
    [[NetworkManager sharedNetwork] performRequestWithUrl:user.photoURL onSuccess:^(NSData * _Nonnull data) {
      
      UIImage *image = [UIImage imageWithData:data];
      
      if (image) {
        [[ImageCacher sharedImageCacher] cacheImage:image forUrl:user.photoURL];
        dispatch_async(dispatch_get_main_queue(), ^{
          cell.imageView.image = image;
          [cell setNeedsLayout];
        });
      }
      
    } onFailure:^(NSError * _Nonnull error) {
      
      NSLog(@"Image error: %@", error);
    }];
  }
  
  return cell;
}

#pragma mark - Utility

- (void)loadMoreUsersFromRow:(NSInteger)row {
  
  __weak UITableView *weakTableView = self.tableView;
  [self.friendList loadMoreWithCompletion:^(NSUInteger count) {
    
    if (weakTableView) {
      
      [weakTableView performBatchUpdates:^{
        
        NSLog(@"Count: %zd", count);
        
        NSMutableArray *newPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < count; i++) {
          [newPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        [weakTableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationAutomatic];
      } completion:^(BOOL finished) {
        
      }];
    }
  }];
}

@end
