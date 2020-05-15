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
    
    [self loadMoreUsersAfterRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    cell.imageView.image = nil;
    
    if (indexPath.row == self.friendList.count - 1) {
        [self loadMoreUsersAfterRow:indexPath.row];
    }
    
    /*if (cell.dataTask) {
        [cell.dataTask cancel];
    }*/
    
    
    User *user = [self.friendList userAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%td %@ %@", indexPath.row, user.firstName, user.lastName];
    
    //UIImage *img = [[ImageCacher sharedImageCacher] getImageForUrl:user.photoURL];
    
    /*if (img) {
        cell.imageView.image = img;
    } else {
        cell.dataTask = [[NSURLSession sharedSession]
                         dataTaskWithURL:user.photoURL
                         completionHandler:^(NSData * _Nullable data,
                                             NSURLResponse * _Nullable response,
                                             NSError * _Nullable error) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (!error) {
                                     UIImage *tmpImg = [UIImage imageWithData:data];
                                     [[ImageCacher sharedImageCacher] cacheImage:tmpImg forUrl:user.photoURL];
                                     [tableView performBatchUpdates:^{
                                         cell.imageView.image = tmpImg;
                                     } completion:nil];
                                 }
                             });
                         }];
        [cell.dataTask resume];
    }*/
    
    return cell;
}

#pragma mark - Utility

- (void)loadMoreUsersAfterRow:(NSInteger)row {
  
  __weak UITableView *weakTableView = self.tableView;
  [self.friendList loadMoreWithCompletion:^(NSUInteger count) {
    
    if (weakTableView) {
      
      [weakTableView performBatchUpdates:^{
        
        NSMutableArray *newPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < count; i++) {
          [newPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        [weakTableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationAutomatic];
      } completion:^(BOOL finished) {
        
        NSLog(@"New cells added");
      }];
    }
  }];
}

- (void)showLoader {
    
}

- (void)hideLoader {
    
}

@end
