//
//  WallTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 28/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "WallTableViewController.h"
#import "WallPostsDataSource.h"
#import "WallPostsList.h"
#import "CSAPIBasicTask-Swift.h"
#import "ImageCache.h"

@interface WallTableViewController ()

@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) id<WallPostsDataSource> wallPosts;
@property (strong, nonatomic) NSOperationQueue *sharedOperationQueue;
@property (strong, nonatomic) NSCache *cachedHeights;

@end

@implementation WallTableViewController

- (instancetype)initWithOwnerID:(NSString *)ownerID {
    self = [super init];
    if (self) {
        _ownerID = ownerID;
        _wallPosts = [[WallPostsList alloc] initWithOwnerID:ownerID];
        _sharedOperationQueue = [NSOperationQueue new];
        _sharedOperationQueue.maxConcurrentOperationCount = 1;
        _cachedHeights = [NSCache new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Wall";
    
    self.tableView.allowsMultipleSelection = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedRowHeight = 400.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadMorePostsFromRow:0];
    
    [self.tableView registerClass:[WallPostTableViewCell class] forCellReuseIdentifier:@"wallPost"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wallPosts.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.cachedHeights objectForKey:indexPath];
    if (height) {
        return height.floatValue;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WallPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wallPost" forIndexPath:indexPath];
    
    WallPost *wallPost = [self.wallPosts wallPostAtIndex:indexPath.row];
    
    [self configureCell:cell atIndexPath:indexPath withWallPost:wallPost];
    
    return cell;
}

- (void)configureCell:(WallPostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withWallPost:(WallPost *)wallPost {
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = wallPost.text;
    [cell.stackView addArrangedSubview:textLabel];
    
    for (id<Attachment> attachment in wallPost.attachments) {
        switch (attachment.type) {
            case AttachmentTypePhoto:{
                
                Photo *photo = attachment;
                PhotoSize *maxSize = [photo.sizes firstObject];
                
                for (PhotoSize *size in photo.sizes) {
                    if (size.height > maxSize.height) {
                        maxSize = size;
                    }
                }
                
                [self addImageFromUrl:maxSize.url toCell:cell atIndexPath:indexPath];
                
                break;
            }
            default:
                break;
        }
    }
}

- (void)addImageFromUrl:(NSURL *)url toCell:(WallPostTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *cached = [ImageCache.publicCache imageWithUrl:url];
    if (cached) {
        CGFloat scale = self.tableView.frame.size.width / cached.size.width;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:cached];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        NSLayoutConstraint *constraint = [imgView.heightAnchor constraintLessThanOrEqualToConstant:cached.size.height * scale];
        [NSLayoutConstraint activateConstraints:@[constraint]];
        [cell.stackView addArrangedSubview:imgView];
        [self.cachedHeights setObject:[NSNumber numberWithFloat:cell.totalHeight] forKey:indexPath];
    } else {
        __weak WallTableViewController *weakSelf = self;
        [ImageCache.publicCache loadWithUrl:url completion:^(UIImage * _Nullable image) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
        }];
    }
}

#pragma mark - Utility

- (void)loadMorePostsFromRow:(NSInteger)row {
    
    [self.wallPosts fetchWallPostsWithCompletion:^(NSUInteger fetchedWallPostsCount) {
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (NSUInteger i = 0; i < fetchedWallPostsCount; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:row+i inSection:0]];
        }
        
        __weak WallTableViewController *weakSelf = self;
        
        [self.sharedOperationQueue addOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView performBatchUpdates:^{
                    [weakSelf.tableView
                     insertRowsAtIndexPaths:indexPaths
                     withRowAnimation:UITableViewRowAnimationAutomatic];
                } completion:nil];
            });
        }];
    }];
}

@end
