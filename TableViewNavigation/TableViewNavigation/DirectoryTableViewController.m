//
//  DirectoryTableViewController.m
//  TableViewNavigation
//
//  Created by Aleksandr on 19/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "DirectoryTableViewController.h"
#import "DirectoryDataSource.h"
#import "DirectoryCell.h"
#import "FileCell.h"

@interface DirectoryTableViewController ()

@property (strong, nonatomic) DirectoryDataSource *dataSource;

@end

@implementation DirectoryTableViewController

- (instancetype)initWithFolderPath:(NSString *)path {
    self = [super init];
    if (self) {
        self.dataSource = [[DirectoryDataSource alloc] initWithFolderPath:path];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = [self.dataSource.selectedPath lastPathComponent];
    [self.dataSource refreshContent];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
    [self.tableView reloadData];
    
    [self.tableView registerClass:[DirectoryCell class]
           forCellReuseIdentifier:NSStringFromClass([DirectoryCell class])];
    [self.tableView registerClass:[FileCell class] forCellReuseIdentifier:NSStringFromClass([FileCell class])];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                             target:self
                             action:@selector(actionAdd:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, item, nil];
}

#pragma mark - Actions

- (void)actionAdd:(UIBarButtonItem *)sender {
    UIAlertController *allertController = [UIAlertController alertControllerWithTitle:@"Add folder"
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [allertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"New folder name";
        [textField becomeFirstResponder];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Add"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         NSString *directoryPath = [self.dataSource.selectedPath stringByAppendingPathComponent:allertController.textFields.firstObject.text];
                                                         [[NSFileManager defaultManager]
                                                          createDirectoryAtPath:directoryPath
                                                          withIntermediateDirectories:NO
                                                          attributes:nil
                                                          error:nil];
                                                         [allertController.textFields.firstObject resignFirstResponder];
                                                         [self.dataSource refreshContent];
                                                         [self.tableView reloadData];
                                                     }];
    [allertController addAction:cancelAction];
    [allertController addAction:okAction];
    [self presentViewController:allertController animated:YES completion:nil];
}

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.dataSource isDirectoryAtIndexPath:indexPath]) {
        NSString *filename = [self.dataSource directoryNameAtIndexPath:indexPath];
        NSString *path = [self.dataSource.selectedPath stringByAppendingPathComponent:filename];
        
        DirectoryTableViewController *vc = [[DirectoryTableViewController alloc] initWithFolderPath:path];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
