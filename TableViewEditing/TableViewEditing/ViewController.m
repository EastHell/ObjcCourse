//
//  ViewController.m
//  TableViewEditing
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "Model/Organization.h"
#import "Extensions/NSString+Utility.h"
#import "ArrayDataSource.h"

@interface ViewController () <UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Organization *> *organizationsArray;
@property (strong, nonatomic) ArrayDataSource *arrayDataSource;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    self.tableView.allowsSelectionDuringEditing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.organizationsArray = [NSMutableArray array];
    self.arrayDataSource = [[ArrayDataSource alloc] initWithOranizations:self.organizationsArray];
    self.tableView.dataSource = self.arrayDataSource;
    
    self.navigationItem.title = @"Organizations";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                   target:self
                                   action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(actionAddSection:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)actionEdit:(UIBarButtonItem *)sender {
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing) {
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *editBUtton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:item
                                   target:self
                                   action:@selector(actionEdit:)];
    
    [self.navigationItem setRightBarButtonItem:editBUtton animated:YES];
}

- (void)actionAddSection:(UIBarButtonItem *)sender {
    Organization *organization = [[Organization alloc] initWithOrganizationName:[NSString randomNameWithMaxLength:10]];
    
    [self.organizationsArray insertObject:organization atIndex:0];
    
    [self.tableView beginUpdates];
    
    NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:0];
    
    [self.tableView insertSections:insertSections withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.row == 0) {
        return [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row + 1 inSection:proposedDestinationIndexPath.section];
    } else {
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        Organization *organization = [self.organizationsArray objectAtIndex:indexPath.section];
        
        NSMutableArray *tempWorkersArray = nil;
        
        if (organization.workers) {
            tempWorkersArray = [NSMutableArray arrayWithArray:organization.workers];
        } else {
            tempWorkersArray = [NSMutableArray array];
        }
        
        Worker *newWorker = [[Worker alloc] initWithName:[NSString randomNameWithMaxLength:10] Salary:arc4random_uniform(40000)];
        [tempWorkersArray insertObject:newWorker atIndex:0];
        organization.workers = tempWorkersArray;
        
        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
    }
}



@end
