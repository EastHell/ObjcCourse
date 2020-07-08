//
//  DetailedFriendTableViewController.m
//  CSAPIBasicTask
//
//  Created by Aleksandr on 04/07/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

#import "DetailedFriendTableViewController.h"

@interface DetailedFriendTableViewController ()

@property (strong, nonatomic) NSArray<NSString *> *cells;
@property (strong, nonatomic) NSString *userId;

@end

@implementation DetailedFriendTableViewController

- (instancetype)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        self.userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = @[@"FirstName", @"LastName", @"City", @"Photo", @"Sex", @"Bdate"];
    
    self.navigationItem.title = @"Friend bio";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = self.cells[indexPath.row];
    
    return cell;
}

@end
