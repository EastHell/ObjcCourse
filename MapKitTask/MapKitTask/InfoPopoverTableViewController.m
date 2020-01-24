//
//  InfoPopoverTableViewController.m
//  MapKitTask
//
//  Created by Aleksandr on 08/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "InfoPopoverTableViewController.h"
#import "NameValueCell.h"

@interface InfoPopoverTableViewController () <UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSDictionary<NSString *, NSString *> *properties;

@end

@implementation InfoPopoverTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.properties = @{@"Name:" : self.name,
                        @"Second name:" : self.secondName,
                        @"Date of birth:" : self.dateOfBirth,
                        @"Sex:" : self.sex,
                        @"Address:" : self.address};
    [self.tableView reloadData];
}

- (void)setup {
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.delegate = self;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.properties.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Information";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NameValueCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NameValueCell class])];
    
    NSArray<NSString *> *names = [self.properties allKeys];
    NSString *name = names[indexPath.row];
    cell.nameLabel.text = name;
    cell.valueLabel.text = self.properties[name];
    
    return cell;
}

@end
