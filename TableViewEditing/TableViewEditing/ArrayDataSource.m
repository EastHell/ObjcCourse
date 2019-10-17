//
//  ArrayDataSource.m
//  TableViewEditing
//
//  Created by Aleksandr on 16/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource()

@property (strong, nonatomic) NSArray<Organization *> *organizations;

@end

@implementation ArrayDataSource

- (id)init {
    return nil;
}

- (id)initWithOranizations:(NSArray<Organization *> *)organizations {
    self = [super init];
    if (self) {
        self.organizations = organizations;
    }
    return self;
}

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.organizations.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.organizations[section].name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.organizations[section].workers.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *addWorkerIdentifier = @"AddWorkerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addWorkerIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:addWorkerIdentifier];
            cell.textLabel.textColor = [UIColor greenColor];
            cell.textLabel.text = @"Add new Worker";
        }
        
        return cell;
    } else {
        static NSString *workerIdentifier = @"WorkerCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workerIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleValue1
                    reuseIdentifier:workerIdentifier];
            
        }
        
        Organization *organization = self.organizations[indexPath.section];
        Worker *worker = organization.workers[indexPath.row - 1];
        
        cell.textLabel.text = worker.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd", worker.salary];
        
        if (worker.salary < 20000) {
            cell.detailTextLabel.textColor = [UIColor redColor];
        } else {
            cell.detailTextLabel.textColor = [UIColor greenColor];
        }
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Organization *sourceOrganization = [self.organizations objectAtIndex:sourceIndexPath.section];
    Worker *worker = [sourceOrganization.workers objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempWorkersArray = [NSMutableArray arrayWithArray:sourceOrganization.workers];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [tempWorkersArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceOrganization.workers = tempWorkersArray;
    } else {
        [tempWorkersArray removeObject:worker];
        sourceOrganization.workers = tempWorkersArray;
        
        Organization *destinationOrganization = [self.organizations objectAtIndex:destinationIndexPath.section];
        tempWorkersArray = [NSMutableArray arrayWithArray:destinationOrganization.workers];
        [tempWorkersArray insertObject:worker atIndex:destinationIndexPath.row - 1];
        destinationOrganization.workers = tempWorkersArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Organization *sourceOrganization = [self.organizations objectAtIndex:indexPath.section];
        Worker *worker = [sourceOrganization.workers objectAtIndex:indexPath.row - 1];
        
        NSMutableArray *tempWorkersArray = [NSMutableArray arrayWithArray:sourceOrganization.workers];
        [tempWorkersArray removeObject:worker];
        sourceOrganization.workers = tempWorkersArray;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    }
}

@end
