//
//  SubscriptionsTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 22/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "SubscriptionsTableViewController.h"
#import "SubscriptionsList.h"
#import "FriendTableViewCell.h"
#import "ImageCache.h"

@interface SubscriptionsTableViewController ()

@property (strong, nonatomic) id<SubscriptionsDataSource> subscriptions;
@property (strong, nonatomic) NSOperationQueue *sharedOperationQueue;
@property (strong, nonatomic) NSString *userID;

@end

@implementation SubscriptionsTableViewController

- (instancetype)initWithUserID:(NSString *)userID
{
    self = [super init];
    if (self) {
        _userID = userID;
        _subscriptions = [[SubscriptionsList alloc] initWithUserID:userID];
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
    
    self.navigationItem.title = @"Subscriptions";
    
    [self.tableView
     registerClass:[FriendTableViewCell class]
     forCellReuseIdentifier:NSStringFromClass([FriendTableViewCell class])];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMoreSubscriptionsFromRow:0];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subscriptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendTableViewCell *cell = [tableView
                                 dequeueReusableCellWithIdentifier:NSStringFromClass([FriendTableViewCell class])
                                 forIndexPath:indexPath];
    
    if (indexPath.row == self.subscriptions.count - 20) {
        [self loadMoreSubscriptionsFromRow:self.subscriptions.count];
    }
    
    Subscription *subscription = [self.subscriptions subscriptionAtIndex:indexPath.row];
    [cell configureWithUserName:subscription.name];
    
    [[ImageCache publicCache] loadWithUrl:subscription.photo_50 completion:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell addImage:image];
            [cell setNeedsLayout];
        });
    }];
    
    return cell;
}

#pragma mark - Utility

- (void)loadMoreSubscriptionsFromRow:(NSInteger)row {
    
    [self.subscriptions fetchSubscriptionsWithCompletion:^(NSUInteger fetchedSubscriptionsCount) {
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < fetchedSubscriptionsCount; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        __weak SubscriptionsTableViewController *weakSelf = self;
        
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
